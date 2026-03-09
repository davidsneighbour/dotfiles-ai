const standardVersion = {
  bumpFiles: [{ filename: "package.json", type: "json" }],

  // for available options in the conventional changelog configuration spec see
  // https://github.com/conventional-changelog/conventional-changelog-config-spec/blob/master/versions/2.2.0/README.md
  header: "# Changelog",
  releaseCount: 1,
  scripts: {
    prerelease: "./.github/prerelease",
  },
  types: [
    { type: "content", section: "Content" },
    { type: "docs", section: "Documentation" },
    { type: "feat", section: "Features" },
    { type: "theme", section: "Theme" },
    { type: "style", section: "Styling" },
    { type: "refactor", section: "Refactors" },
    { type: "test", section: "Tests" },
    { type: "chore", section: "Chore" },
    { type: "config", section: "Configuration" },
    { type: "build", section: "Build System" },
    { type: "ci", section: "CI" },
  ]
};

module.exports = standardVersion;
