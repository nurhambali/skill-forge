setup() {
    TEST_DIR=$(mktemp -d)
    SCRIPT_DIR="$(dirname "$BATS_TEST_DIRNAME")"
}

teardown() {
    rm -rf "$TEST_DIR"
}

@test "setup-project.sh --help exits successfully" {
    run bash "$SCRIPT_DIR/setup-project.sh" --help
    [ "$status" -eq 0 ]
}

@test "setup-project.sh --opencode creates .opencode directory" {
    run bash "$SCRIPT_DIR/setup-project.sh" --opencode "$TEST_DIR" "Test Project"
    [ "$status" -eq 0 ]
    [ -d "$TEST_DIR/.opencode" ]
    [ -f "$TEST_DIR/.opencode/AGENTS.md" ]
    [ -f "$TEST_DIR/.opencode/opencode.json" ]
}

@test "setup-project.sh --claude creates CLAUDE.md" {
    run bash "$SCRIPT_DIR/setup-project.sh" --claude "$TEST_DIR" "Test Project"
    [ "$status" -eq 0 ]
    [ -f "$TEST_DIR/CLAUDE.md" ]
    [ -d "$TEST_DIR/.claude" ]
}

@test "setup-project.sh --copilot creates COPILOT.md" {
    run bash "$SCRIPT_DIR/setup-project.sh" --copilot "$TEST_DIR" "Test Project"
    [ "$status" -eq 0 ]
    [ -f "$TEST_DIR/COPILOT.md" ]
}

@test "setup-project.sh --cursor creates .cursorrules" {
    run bash "$SCRIPT_DIR/setup-project.sh" --cursor "$TEST_DIR" "Test Project"
    [ "$status" -eq 0 ]
    [ -f "$TEST_DIR/.cursorrules" ]
    [ -d "$TEST_DIR/.cursor" ]
}

@test "setup-project.sh --kiro creates .kiro/rules.md" {
    run bash "$SCRIPT_DIR/setup-project.sh" --kiro "$TEST_DIR" "Test Project"
    [ "$status" -eq 0 ]
    [ -f "$TEST_DIR/.kiro/rules.md" ]
}

@test "setup-project.sh --antigravity creates .antigravity/rules.md" {
    run bash "$SCRIPT_DIR/setup-project.sh" --antigravity "$TEST_DIR" "Test Project"
    [ "$status" -eq 0 ]
    [ -f "$TEST_DIR/.antigravity/rules.md" ]
}

@test "setup-project.sh creates AGENTS.md and .wiki for all tools" {
    run bash "$SCRIPT_DIR/setup-project.sh" --opencode "$TEST_DIR" "Test Project"
    [ "$status" -eq 0 ]
    [ -f "$TEST_DIR/AGENTS.md" ]
    [ -d "$TEST_DIR/.wiki" ]
    [ -f "$TEST_DIR/.wiki/index.md" ]
    [ -f "$TEST_DIR/.wiki/log.md" ]
    [ -f "$TEST_DIR/.wiki/architecture.md" ]
    [ -f "$TEST_DIR/.wiki/issues.md" ]
}

@test "sync-skills.sh runs without errors" {
    run bash "$SCRIPT_DIR/sync-skills.sh"
    [ "$status" -eq 0 ]
    [ -d "$SCRIPT_DIR/skills" ]
}

@test "setup-project.sh fails with unknown tool" {
    run bash "$SCRIPT_DIR/setup-project.sh" --unknown-tool "$TEST_DIR"
    [ "$status" -eq 1 ]
}

@test "setup-project.sh without arguments uses current dir" {
    cd "$TEST_DIR"
    run bash "$SCRIPT_DIR/setup-project.sh" --opencode
    [ "$status" -eq 0 ]
    [ -f "$TEST_DIR/.opencode/AGENTS.md" ]
}
