package main

import (
	"bufio"
	"bytes"
	"flag"
	"fmt"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"sort"
	"strconv"
	"strings"
	"text/template"
)

type config struct {
	FormulaName  string
	ClassName    string
	Description  string
	Homepage     string
	Repo         string
	License      string
	AssetPrefix  string
	AssetPattern string
	Install      string
	Test         string
}

type asset struct {
	URL    string
	SHA256 string
}

type formulaData struct {
	ClassName   string
	Description string
	Homepage    string
	Version     string
	License     string
	DarwinARM64 asset
	DarwinAMD64 asset
	LinuxARM64  asset
	LinuxAMD64  asset
	Install     string
	Test        string
}

var formulaConfigs = map[string]config{
	"scut": {
		FormulaName:  "scut",
		ClassName:    "Scut",
		Description:  "CLI toolkit for LLM agents, Claude Code hooks, status lines, and formatting",
		Homepage:     "https://github.com/ajbeck/scut",
		Repo:         "ajbeck/scut",
		License:      "MIT",
		AssetPrefix:  "scut",
		AssetPattern: "{name}-{tag}-{goos}-{goarch}.tar.gz",
		Install:      `bin.install "scut"`,
		Test:         `assert_match version.to_s, shell_output("#{bin}/scut version")`,
	},
}

func main() {
	formula := flag.String("formula", "", "formula name to update")
	version := flag.String("version", "", "release version, for example v0.3.0")
	flag.Parse()

	if *formula == "" || *version == "" {
		fatalf("-formula and -version are required")
	}

	cfg, ok := formulaConfigs[*formula]
	if !ok {
		names := make([]string, 0, len(formulaConfigs))
		for name := range formulaConfigs {
			names = append(names, name)
		}
		sort.Strings(names)
		fatalf("unsupported formula %q; supported formulae: %s", *formula, strings.Join(names, ", "))
	}

	tag := normalizeTag(*version)
	checksums, err := fetchChecksums(cfg.Repo, tag)
	if err != nil {
		fatalf("%v", err)
	}

	data, err := buildFormulaData(cfg, tag, checksums)
	if err != nil {
		fatalf("%v", err)
	}

	rendered, err := renderFormula(data)
	if err != nil {
		fatalf("%v", err)
	}

	path := filepath.Join("Formula", cfg.FormulaName+".rb")
	if err := os.WriteFile(path, rendered, 0644); err != nil {
		fatalf("writing %s: %v", path, err)
	}
}

func normalizeTag(version string) string {
	if strings.HasPrefix(version, "v") {
		return version
	}
	return "v" + version
}

func fetchChecksums(repo, tag string) (map[string]string, error) {
	url := fmt.Sprintf("https://github.com/%s/releases/download/%s/checksums.txt", repo, tag)
	resp, err := http.Get(url)
	if err != nil {
		return nil, fmt.Errorf("fetching %s: %w", url, err)
	}
	defer resp.Body.Close()
	if resp.StatusCode != http.StatusOK {
		body, _ := io.ReadAll(io.LimitReader(resp.Body, 1024))
		return nil, fmt.Errorf("fetching %s: status %s: %s", url, resp.Status, strings.TrimSpace(string(body)))
	}
	return parseChecksums(resp.Body)
}

func parseChecksums(r io.Reader) (map[string]string, error) {
	checksums := make(map[string]string)
	scanner := bufio.NewScanner(r)
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line == "" {
			continue
		}
		fields := strings.Fields(line)
		if len(fields) < 2 {
			return nil, fmt.Errorf("invalid checksum line %q", line)
		}
		sha := fields[0]
		name := filepath.Base(fields[len(fields)-1])
		checksums[name] = sha
	}
	if err := scanner.Err(); err != nil {
		return nil, fmt.Errorf("reading checksums: %w", err)
	}
	return checksums, nil
}

func buildFormulaData(cfg config, tag string, checksums map[string]string) (formulaData, error) {
	version := strings.TrimPrefix(tag, "v")
	assetFor := func(goos, goarch string) (asset, error) {
		name := renderAssetName(cfg, tag, goos, goarch)
		sha, ok := checksums[name]
		if !ok {
			return asset{}, fmt.Errorf("checksum for %s not found", name)
		}
		return asset{
			URL:    fmt.Sprintf("https://github.com/%s/releases/download/%s/%s", cfg.Repo, tag, name),
			SHA256: sha,
		}, nil
	}

	darwinARM64, err := assetFor("darwin", "arm64")
	if err != nil {
		return formulaData{}, err
	}
	darwinAMD64, err := assetFor("darwin", "amd64")
	if err != nil {
		return formulaData{}, err
	}
	linuxARM64, err := assetFor("linux", "arm64")
	if err != nil {
		return formulaData{}, err
	}
	linuxAMD64, err := assetFor("linux", "amd64")
	if err != nil {
		return formulaData{}, err
	}

	return formulaData{
		ClassName:   cfg.ClassName,
		Description: cfg.Description,
		Homepage:    cfg.Homepage,
		Version:     version,
		License:     cfg.License,
		DarwinARM64: darwinARM64,
		DarwinAMD64: darwinAMD64,
		LinuxARM64:  linuxARM64,
		LinuxAMD64:  linuxAMD64,
		Install:     cfg.Install,
		Test:        cfg.Test,
	}, nil
}

func renderAssetName(cfg config, tag, goos, goarch string) string {
	replacer := strings.NewReplacer(
		"{name}", cfg.AssetPrefix,
		"{tag}", tag,
		"{version}", strings.TrimPrefix(tag, "v"),
		"{goos}", goos,
		"{goarch}", goarch,
	)
	return replacer.Replace(cfg.AssetPattern)
}

func renderFormula(data formulaData) ([]byte, error) {
	tmpl, err := template.New("formula").
		Funcs(template.FuncMap{
			"indent": indent,
			"quote":  strconv.Quote,
		}).
		ParseFiles(filepath.Join(".github", "formula-templates", "tarball.rb.tmpl"))
	if err != nil {
		return nil, fmt.Errorf("parsing formula template: %w", err)
	}
	var buf bytes.Buffer
	if err := tmpl.ExecuteTemplate(&buf, "tarball.rb.tmpl", data); err != nil {
		return nil, fmt.Errorf("rendering formula template: %w", err)
	}
	return buf.Bytes(), nil
}

func indent(width int, text string) string {
	pad := strings.Repeat(" ", width)
	lines := strings.Split(text, "\n")
	for i, line := range lines {
		if line != "" {
			lines[i] = pad + line
		}
	}
	return strings.Join(lines, "\n")
}

func fatalf(format string, args ...any) {
	fmt.Fprintf(os.Stderr, format+"\n", args...)
	os.Exit(1)
}
