---
name: testing-patterns
description: |
  Pattern e metriche per testing, performance benchmarking, e quality analysis.
  Contiene framework, template e best practices comuni a tutti gli agenti testing.
user-invocable: false
disable-model-invocation: true
---

# Testing Patterns & Metrics

## Performance Metrics Targets

### Web Vitals (Good/Needs Improvement/Poor)

| Metric | Good | Needs Work | Poor |
|--------|------|------------|------|
| LCP | <2.5s | <4s | >4s |
| FID | <100ms | <300ms | >300ms |
| CLS | <0.1 | <0.25 | >0.25 |
| FCP | <1.8s | <3s | >3s |
| TTI | <3.8s | <7.3s | >7.3s |

### Backend Performance

| Metric | Target |
|--------|--------|
| API Response | <200ms (p95) |
| Database Query | <50ms (p95) |
| Background Jobs | <30s (p95) |
| Memory Usage | <512MB per instance |
| CPU Usage | <70% sustained |

### Mobile Performance

| Metric | Target |
|--------|--------|
| App Startup | <3s cold start |
| Frame Rate | 60fps for animations |
| Memory Usage | <100MB baseline |
| Battery Drain | <2% per hour active |

### Test Health

| Metric | Green | Yellow | Red |
|--------|-------|--------|-----|
| Pass Rate | >95% | >90% | <90% |
| Flaky Rate | <1% | <5% | >5% |
| Coverage | >80% | >60% | <60% |

## Report Templates

### Performance Benchmark

```markdown
## Performance Benchmark: [App Name]
**Date**: [Date]
**Environment**: [Production/Staging]

### Executive Summary
- Current Performance: [Grade]
- Critical Issues: [Count]
- Potential Improvement: [X%]

### Key Metrics
| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| LCP | Xs | <2.5s | ❌/✅ |

### Top Bottlenecks
1. [Issue] - Impact: Xs - Fix: [Solution]

### Recommendations
#### Immediate (This Sprint)
1. [Specific fix with expected impact]
```

### Quality Report

```markdown
## Sprint Quality Report: [Sprint Name]
**Period**: [Start] - [End]
**Overall Health**: 🟢/🟡/🔴

### Executive Summary
- **Test Pass Rate**: X% (↑/↓ Y%)
- **Code Coverage**: X%
- **Defects Found**: X (Y critical)
- **Flaky Tests**: X

### Key Insights
1. [Finding with impact]

### Trends
| Metric | This Sprint | Last Sprint | Trend |
|--------|-------------|-------------|-------|
| Pass Rate | X% | Y% | ↑/↓ |
```

### Flaky Test Report

```markdown
## Flaky Test Analysis
**Period**: [Last X days]
**Total Flaky Tests**: X

### Top Flaky Tests
| Test | Failure Rate | Pattern | Priority |
|------|--------------|---------|----------|
| test_name | X% | Time/Order/Env | High |

### Root Cause Analysis
1. **Timing Issues** (X tests) - Fix: Add proper waits/mocks
2. **Test Isolation** (Y tests) - Fix: Clean state between tests
```

## Quick Commands

```bash
# Performance test
curl -o /dev/null -s -w "Time: %{time_total}s\n" URL

# Memory snapshot
ps aux | grep node | awk '{print $6}'

# Bundle size
du -sh dist/*.js | sort -h

# Test pass rate
grep -E "passed|failed" test-results.log | awk '{count[$2]++} END {for (i in count) print i, count[i]}'

# Find slowest tests
grep "duration" test-results.json | sort -k2 -nr | head -20
```

## Optimization Strategies

### Quick Wins (Hours)

- Enable compression (gzip/brotli)
- Add database indexes
- Implement basic caching
- Optimize images
- Remove unused code
- Fix obvious N+1 queries

### Medium Efforts (Days)

- Implement code splitting
- Add CDN for static assets
- Optimize database schema
- Implement lazy loading
- Add service workers

### Major Improvements (Weeks)

- Rearchitect data flow
- Implement micro-frontends
- Add read replicas
- Migrate to faster tech
- Rewrite critical algorithms

## Common Issues Checklist

### Frontend
- [ ] Render-blocking resources
- [ ] Unoptimized images
- [ ] Excessive JavaScript
- [ ] Layout thrashing
- [ ] Memory leaks

### Backend
- [ ] N+1 database queries
- [ ] Missing indexes
- [ ] Synchronous I/O
- [ ] Inefficient algorithms
- [ ] Connection pool exhaustion

### Tests
- [ ] Flaky tests
- [ ] Slow tests
- [ ] Missing coverage
- [ ] Test isolation issues
- [ ] Environment dependencies

## Tool Integration

### Profiling Tools

| Area | Tools |
|------|-------|
| Frontend | Chrome DevTools, Lighthouse, WebPageTest |
| Backend | APM, query analyzers, profilers |
| Mobile | Xcode Instruments, Android Studio Profiler |
| Tests | Jest, Pytest, k6, JMeter |

### Monitoring

- Four Golden Signals: latency, traffic, errors, saturation
- Business metrics tracking
- User experience monitoring
- Cost tracking
