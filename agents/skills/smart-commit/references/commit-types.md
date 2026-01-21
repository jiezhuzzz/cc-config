# Conventional Commit Types

Detailed guide for categorizing changes into conventional commit types.

## Type Definitions

### feat (Feature)
**Purpose:** New functionality added to the codebase

**Examples:**
- Adding a new API endpoint
- Creating a new UI component
- Implementing a new user-facing feature
- Adding a new command or option
- Introducing new capabilities

**Code patterns:**
- New functions, classes, or modules
- New exports
- New configuration options
- New dependencies added for new features

**Example commits:**
```
feat(api): add user profile endpoint
feat(ui): add dark mode toggle
feat(auth): implement OAuth login
feat(cli): add --verbose flag
```

### fix (Bug Fix)
**Purpose:** Fixing incorrect behavior

**Examples:**
- Correcting logic errors
- Fixing crashes or exceptions
- Resolving incorrect calculations
- Patching security vulnerabilities
- Fixing race conditions

**Code patterns:**
- Changes to conditional logic (if/else)
- Fixing off-by-one errors
- Correcting variable assignments
- Adding null checks
- Exception handling improvements

**Example commits:**
```
fix(api): prevent null pointer in user lookup
fix(auth): correct token expiration logic
fix(ui): resolve button click handler crash
fix(db): fix SQL injection vulnerability
```

### refactor (Code Restructuring)
**Purpose:** Code changes that neither fix bugs nor add features - pure internal improvements

**Examples:**
- Renaming variables, functions, or classes
- Extracting methods or functions
- Moving code between files
- Simplifying complex logic
- Removing code duplication
- Changing internal data structures

**Code patterns:**
- Renamed identifiers
- Code moved between functions/files
- Logic simplified but behavior unchanged
- Extract/inline refactorings
- Pattern changes (e.g., callback → promise)

**Example commits:**
```
refactor(auth): rename getUserData to fetchUserProfile
refactor(api): extract validation logic into separate function
refactor(ui): simplify component state management
refactor(db): consolidate duplicate query logic
```

### chore (Maintenance)
**Purpose:** Maintenance tasks that don't modify src or test files

**Examples:**
- Updating dependencies
- Changing build configuration
- Modifying tooling setup
- Updating .gitignore
- Package.json changes (not adding new features)
- CI/CD configuration updates

**Code patterns:**
- Package.json/requirements.txt/go.mod updates
- Webpack/rollup/vite config changes
- ESLint/prettier config changes
- Docker/docker-compose changes
- Makefile updates

**Example commits:**
```
chore(deps): update axios to v1.6.0
chore(build): configure webpack for production
chore(config): add .env.example template
chore(deps): bump lodash from 4.17.19 to 4.17.21
```

### docs (Documentation)
**Purpose:** Documentation-only changes

**Examples:**
- README updates
- Adding/updating code comments
- JSDoc/docstring changes
- CHANGELOG updates
- Adding examples
- API documentation

**Code patterns:**
- Markdown file changes
- Comment-only changes
- Docstring additions/updates
- No executable code changes

**Example commits:**
```
docs(readme): add installation instructions
docs(api): update authentication flow diagram
docs(contributing): add code style guidelines
docs(auth): clarify token refresh logic in comments
```

### style (Code Style)
**Purpose:** Formatting changes that don't affect code meaning

**Examples:**
- Whitespace changes
- Missing semicolons
- Code formatting
- Indentation fixes
- Line breaks

**Code patterns:**
- Prettier/formatter changes
- Semicolon additions/removals
- Indentation changes
- Trailing whitespace removal
- Line length adjustments

**Example commits:**
```
style(api): fix indentation in user controller
style(ui): remove trailing whitespace
style(auth): add missing semicolons
style: run prettier on all files
```

### test (Tests)
**Purpose:** Adding or updating tests - no production code changes

**Examples:**
- Adding new test cases
- Updating existing tests
- Adding test fixtures
- Improving test coverage
- Refactoring tests

**Code patterns:**
- New test files or test cases
- Changes in test/ or __tests__/ directories
- Test utility updates
- Mock/stub updates
- Test configuration changes

**Example commits:**
```
test(api): add tests for user profile endpoint
test(auth): update login flow test cases
test(ui): add component snapshot tests
test(db): improve query builder coverage
```

### perf (Performance)
**Purpose:** Code changes that improve performance

**Examples:**
- Algorithm optimizations
- Reducing memory usage
- Caching implementations
- Database query optimization
- Reducing bundle size

**Code patterns:**
- Algorithmic changes (O(n²) → O(n))
- Adding memoization/caching
- Lazy loading implementations
- Index additions to databases
- Code splitting

**Example commits:**
```
perf(api): add caching layer for user queries
perf(ui): implement virtual scrolling for large lists
perf(db): add index to users.email column
perf(build): reduce bundle size with code splitting
```

### ci (Continuous Integration)
**Purpose:** CI/CD pipeline and automation changes

**Examples:**
- GitHub Actions workflows
- Jenkins/CircleCI/Travis configuration
- Automated deployment scripts
- Pipeline optimization

**Code patterns:**
- .github/workflows/ changes
- CI configuration files (e.g., .travis.yml, .circleci/config.yml)
- Deployment automation scripts

**Example commits:**
```
ci(github): add automated test workflow
ci(deploy): configure production deployment pipeline
ci(actions): add code coverage reporting
ci(lint): add pre-commit hooks for linting
```

### build (Build System)
**Purpose:** Changes to build system or external dependencies

**Examples:**
- Build tool configuration
- Compiler settings
- Package manager configuration
- Build script changes

**Code patterns:**
- Webpack/rollup/vite config changes that affect builds
- tsconfig.json/babel.config.js changes
- Build scripts (build.sh, compile scripts)

**Example commits:**
```
build(webpack): configure source maps for production
build(typescript): enable strict mode
build(docker): optimize multi-stage build
build(npm): add pre-build script
```

## Decision Trees for Ambiguous Cases

### "Does this add functionality?" YES → feat, NO → continue
### "Does this fix incorrect behavior?" YES → fix, NO → continue
### "Does this change user-facing behavior?" NO → refactor, YES → continue
### "Does this only affect docs/comments?" YES → docs, NO → continue
### "Does this only affect formatting?" YES → style, NO → continue
### "Is this dependency/tooling/config?" YES → chore, NO → continue

## Common Ambiguities

**Adding error handling:** Usually `fix` (prevents crashes) or `feat` (new validation)

**Dependency updates:**
- Security patches → `fix`
- Adding new dependency for feature → `feat`
- Upgrading existing dependency → `chore`

**Config changes:**
- Enabling new feature → `feat`
- Maintenance/cleanup → `chore`
- Build-related → `build`

**Refactoring with small behavior change:**
- If primary purpose is refactoring → `refactor`
- If primary purpose is fixing bug → `fix`
- If adds new capability → `feat`

**Comment changes:**
- Only comments → `docs`
- Comments + code → use code's type
