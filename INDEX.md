# AgenticSharedResources INDEX

This file is the machine-readable entry point for agents and LLMs. Read this first to understand what is available and where to find it. All paths are relative to the repo root.

## Skills

Agent slash-command skills. Each skill is a directory containing a `SKILL.md` that describes what it does, when to invoke it, inputs, outputs, and step-by-step instructions.

### Core Skills

Always installed. High-frequency skills for daily use.

| Skill | Path | Description |
|-------|------|-------------|
| `core/address-github-comments` | `skills/core/address-github-comments` | Efficiently address PR review comments or issue feedback using the GitHub CLI (`gh`). This |
| `core/agent-memory-systems` | `skills/core/agent-memory-systems` | You are a cognitive architect who understands that memory makes agents intelligent. |
| `core/api-documentation-generator` | `skills/core/api-documentation-generator` | Automatically generate clear, comprehensive API documentation from your codebase. This ski |
| `core/api-security-best-practices` | `skills/core/api-security-best-practices` | Guide developers in building secure APIs by implementing authentication, authorization, in |
| `core/architecture` | `skills/core/architecture` | > "Requirements drive architecture. Trade-offs inform decisions. ADRs capture rationale." |
| `core/cc-skill-security-review` | `skills/core/cc-skill-security-review` | This skill ensures all code follows security best practices and identifies potential vulne |
| `core/clean-code` | `skills/core/clean-code` | > **CRITICAL SKILL** - Be **concise, direct, and solution-focused**. |
| `core/context-window-management` | `skills/core/context-window-management` | You're a context engineering specialist who has optimized LLM applications handling |
| `core/diagnose` | `skills/core/diagnose` | A discipline for hard bugs. Skip phases only when explicitly justified. |
| `core/dispatching-parallel-agents` | `skills/core/dispatching-parallel-agents` | When you have multiple unrelated failures (different test files, different subsystems, dif |
| `core/find-skills` | `skills/core/find-skills` | This skill helps you discover and install skills from the open agent skills ecosystem. |
| `core/finishing-a-development-branch` | `skills/core/finishing-a-development-branch` | Guide completion of development work by presenting clear options and handling chosen workf |
| `core/frontend-dev-guidelines` | `skills/core/frontend-dev-guidelines` | Comprehensive guide for modern React development, emphasizing Suspense-based data fetching |
| `core/git-pushing` | `skills/core/git-pushing` | Stage all changes, create a conventional commit, and push to the remote branch. |
| `core/parallel-agents` | `skills/core/parallel-agents` | > Orchestration through Claude Code's built-in Agent Tool |
| `core/performance-profiling` | `skills/core/performance-profiling` | > Measure, analyze, optimize - in that order. |
| `core/plan-writing` | `skills/core/plan-writing` | > Source: obra/superpowers |
| `core/production-code-audit` | `skills/core/production-code-audit` | Autonomously analyze the entire codebase to understand its architecture, patterns, and pur |
| `core/prompt-engineer` | `skills/core/prompt-engineer` | I translate intent into instructions that LLMs actually follow. I know |
| `core/react-best-practices` | `skills/core/react-best-practices` | Comprehensive performance optimization guide for React and Next.js applications, maintaine |
| `core/senior-architect` | `skills/core/senior-architect` | Complete toolkit for senior architect with modern tools and best practices. |
| `core/senior-fullstack` | `skills/core/senior-fullstack` | Complete toolkit for senior fullstack with modern tools and best practices. |
| `core/software-architecture` | `skills/core/software-architecture` | This skill provides guidance for quality focused software development and architecture. It |
| `core/systematic-debugging` | `skills/core/systematic-debugging` | Random fixes waste time and create new bugs. Quick patches mask underlying issues. |
| `core/tailwind-patterns` | `skills/core/tailwind-patterns` | > Modern utility-first CSS with CSS-native configuration. |
| `core/tdd` | `skills/core/tdd` | See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mocking guidelines. |
| `core/test-driven-development` | `skills/core/test-driven-development` | Write the test first. Watch it fail. Write minimal code to pass. |
| `core/ui-ux-pro-max` | `skills/core/ui-ux-pro-max` | Comprehensive design guide for web and mobile applications. Contains 50+ styles, 97 color  |
| `core/write-a-skill` | `skills/core/write-a-skill` | 1. **Gather requirements** - ask user about: |
| `core/writing-plans` | `skills/core/writing-plans` | Write comprehensive implementation plans assuming the engineer has zero context for our co |

### Extended Skills

On-demand. Install with `./install.sh --skill <name>` or all with `./install.sh --extended`.

| Skill | Path | Description |
|-------|------|-------------|
| `extended/3d-web-experience` | `skills/extended/3d-web-experience` | You bring the third dimension to the web. You know when 3D enhances |
| `extended/ab-test-setup` | `skills/extended/ab-test-setup` | You are an expert in experimentation and A/B testing. Your goal is to help design tests th |
| `extended/agent-evaluation` | `skills/extended/agent-evaluation` | You're a quality engineer who has seen agents that aced benchmarks fail spectacularly in |
| `extended/agent-manager-skill` | `skills/extended/agent-manager-skill` | Use this skill when you need to: |
| `extended/agent-memory-mcp` | `skills/extended/agent-memory-mcp` | This skill provides a persistent, searchable memory bank that automatically syncs with pro |
| `extended/agent-tool-builder` | `skills/extended/agent-tool-builder` | You are an expert in the interface between LLMs and the outside world. |
| `extended/ai-agents-architect` | `skills/extended/ai-agents-architect` | I build AI systems that can act autonomously while remaining controllable. |
| `extended/ai-product` | `skills/extended/ai-product` | You are an AI product engineer who has shipped LLM features to millions of |
| `extended/ai-wrapper-product` | `skills/extended/ai-wrapper-product` | You know AI wrappers get a bad rap, but the good ones solve real problems. |
| `extended/algolia-search` | `skills/extended/algolia-search` | Modern React InstantSearch setup using hooks for type-ahead search. |
| `extended/algorithmic-art` | `skills/extended/algorithmic-art` | Algorithmic philosophies are computational aesthetic movements that are then expressed thr |
| `extended/analytics-tracking` | `skills/extended/analytics-tracking` | You are an expert in analytics implementation and measurement. Your goal is to help set up |
| `extended/api-patterns` | `skills/extended/api-patterns` | > API design principles and decision-making for 2025. |
| `extended/app-builder` | `skills/extended/app-builder` | > Analyzes user's requests, determines tech stack, plans structure, and coordinates agents |
| `extended/app-builder/templates` | `skills/extended/app-builder/templates` | > Quick-start templates for scaffolding new projects. |
| `extended/app-store-optimization` | `skills/extended/app-store-optimization` | This comprehensive skill provides complete ASO capabilities for successfully launching and |
| `extended/autonomous-agent-patterns` | `skills/extended/autonomous-agent-patterns` | > Design patterns for building autonomous coding agents, inspired by [Cline](https://githu |
| `extended/autonomous-agents` | `skills/extended/autonomous-agents` | You are an agent architect who has learned the hard lessons of autonomous AI. |
| `extended/autonomous-ai-agents/claude-code` | `skills/extended/autonomous-ai-agents/claude-code` | Delegate coding tasks to [Claude Code](https://docs.anthropic.com/en/docs/claude-code) via |
| `extended/autonomous-ai-agents/codex` | `skills/extended/autonomous-ai-agents/codex` | Delegate coding tasks to [Codex](https://github.com/openai/codex) via the Hermes terminal. |
| `extended/autonomous-ai-agents/hermes-agent` | `skills/extended/autonomous-ai-agents/hermes-agent` | Run additional Hermes Agent processes as autonomous subprocesses. Unlike `delegate_task` ( |
| `extended/autonomous-ai-agents/opencode` | `skills/extended/autonomous-ai-agents/opencode` | Use [OpenCode](https://opencode.ai) as an autonomous coding worker orchestrated by Hermes  |
| `extended/avalonia-layout-zafiro` | `skills/extended/avalonia-layout-zafiro` | > Master modern, clean, and maintainable Avalonia UI layouts. |
| `extended/avalonia-viewmodels-zafiro` | `skills/extended/avalonia-viewmodels-zafiro` | This skill provides a set of best practices and patterns for creating ViewModels, Wizards, |
| `extended/avalonia-zafiro-development` | `skills/extended/avalonia-zafiro-development` | This skill defines the mandatory conventions and behavioral rules for developing cross-pla |
| `extended/aws-serverless` | `skills/extended/aws-serverless` | Proper Lambda function structure with error handling |
| `extended/azure-functions` | `skills/extended/azure-functions` | Modern .NET execution model with process isolation |
| `extended/backend-dev-guidelines` | `skills/extended/backend-dev-guidelines` | Establish consistency and best practices across backend microservices (blog-api, auth-serv |
| `extended/bash-linux` | `skills/extended/bash-linux` | > Essential patterns for Bash on Linux/macOS. |
| `extended/behavioral-modes` | `skills/extended/behavioral-modes` | This skill defines distinct behavioral modes that optimize AI performance for specific tas |
| `extended/brainstorming` | `skills/extended/brainstorming` | Help turn ideas into fully formed designs and specs through natural collaborative dialogue |
| `extended/brand-guidelines-anthropic` | `skills/extended/brand-guidelines-anthropic` | To access Anthropic's official brand identity and style resources, use this skill. |
| `extended/brand-guidelines-community` | `skills/extended/brand-guidelines-community` | To access Anthropic's official brand identity and style resources, use this skill. |
| `extended/browser-automation` | `skills/extended/browser-automation` | You are a browser automation expert who has debugged thousands of flaky tests |
| `extended/browser-extension-builder` | `skills/extended/browser-extension-builder` | You extend the browser to give users superpowers. You understand the |
| `extended/bullmq-specialist` | `skills/extended/bullmq-specialist` | You are a BullMQ expert who has processed billions of jobs in production. |
| `extended/bun-development` | `skills/extended/bun-development` | > Fast, modern JavaScript/TypeScript development with the Bun runtime, inspired by [oven-s |
| `extended/canvas-design` | `skills/extended/canvas-design` | These are instructions for creating design philosophies - aesthetic movements that are the |
| `extended/caveman` | `skills/extended/caveman` | Respond terse like smart caveman. All technical substance stay. Only fluff die. |
| `extended/cc-skill-backend-patterns` | `skills/extended/cc-skill-backend-patterns` | Backend architecture patterns and best practices for scalable server-side applications. |
| `extended/cc-skill-clickhouse-io` | `skills/extended/cc-skill-clickhouse-io` | ClickHouse-specific patterns for high-performance analytics and data engineering. |
| `extended/cc-skill-coding-standards` | `skills/extended/cc-skill-coding-standards` | Universal coding standards applicable across all projects. |
| `extended/cc-skill-continuous-learning` | `skills/extended/cc-skill-continuous-learning` | Development skill skill. |
| `extended/cc-skill-frontend-patterns` | `skills/extended/cc-skill-frontend-patterns` | Modern frontend patterns for React, Next.js, and performant user interfaces. |
| `extended/cc-skill-project-guidelines-example` | `skills/extended/cc-skill-project-guidelines-example` | This is an example of a project-specific skill. Use this as a template for your own projec |
| `extended/cc-skill-strategic-compact` | `skills/extended/cc-skill-strategic-compact` | Development skill skill. |
| `extended/claude-code-guide` | `skills/extended/claude-code-guide` | To provide a comprehensive reference for configuring and using Claude Code (the agentic co |
| `extended/claude-d3js-skill` | `skills/extended/claude-d3js-skill` | This skill provides guidance for creating sophisticated, interactive data visualisations u |
| `extended/clerk-auth` | `skills/extended/clerk-auth` | Complete Clerk setup for Next.js 14/15 App Router. |
| `extended/code-review-checklist` | `skills/extended/code-review-checklist` | Provide a systematic checklist for conducting thorough code reviews. This skill helps revi |
| `extended/competitor-alternatives` | `skills/extended/competitor-alternatives` | You are an expert in creating competitor comparison and alternative pages. Your goal is to |
| `extended/computer-use-agents` | `skills/extended/computer-use-agents` | The fundamental architecture of computer use agents: observe screen, |
| `extended/concise-planning` | `skills/extended/concise-planning` | Turn a user request into a **single, actionable plan** with atomic steps. |
| `extended/content-creator` | `skills/extended/content-creator` | Professional-grade brand voice analysis, SEO optimization, and platform-specific content f |
| `extended/conversation-memory` | `skills/extended/conversation-memory` | You're a memory systems specialist who has built AI assistants that remember |
| `extended/copy-editing` | `skills/extended/copy-editing` | You are an expert copy editor specializing in marketing and conversion copy. Your goal is  |
| `extended/copywriting` | `skills/extended/copywriting` | You are an expert conversion copywriter. Your goal is to write marketing copy that is clea |
| `extended/core-components` | `skills/extended/core-components` | Use components from your core library instead of raw platform components. This ensures con |
| `extended/creative/ascii-art` | `skills/extended/creative/ascii-art` | Multiple tools for different ASCII art needs. All tools are local CLI programs or free RES |
| `extended/creative/ascii-video` | `skills/extended/creative/ascii-video` | This is visual art. ASCII characters are the medium; cinema is the standard. |
| `extended/creative/excalidraw` | `skills/extended/creative/excalidraw` | Create diagrams by writing standard Excalidraw element JSON and saving as `.excalidraw` fi |
| `extended/creative/songwriting-and-ai-music` | `skills/extended/creative/songwriting-and-ai-music` | Everything here is a GUIDELINE, not a rule. Art breaks rules on purpose. |
| `extended/crewai` | `skills/extended/crewai` | You are an expert in designing collaborative AI agent teams with CrewAI. You think |
| `extended/data-science/jupyter-live-kernel` | `skills/extended/data-science/jupyter-live-kernel` | Gives you a **stateful Python REPL** via a live Jupyter kernel. Variables persist |
| `extended/database-design` | `skills/extended/database-design` | > **Learn to THINK, not copy SQL patterns.** |
| `extended/deployment-procedures` | `skills/extended/deployment-procedures` | > Deployment principles and decision-making for safe production releases. |
| `extended/design-md` | `skills/extended/design-md` | You are an expert Design Systems Lead. Your goal is to analyze the provided technical asse |
| `extended/dev-browser` | `skills/extended/dev-browser` | Browser automation that maintains page state across script executions. Write small, focuse |
| `extended/devops/webhook-subscriptions` | `skills/extended/devops/webhook-subscriptions` | Create dynamic webhook subscriptions so external services (GitHub, GitLab, Stripe, CI/CD,  |
| `extended/doc-coauthoring` | `skills/extended/doc-coauthoring` | This skill provides a structured workflow for guiding users through collaborative document |
| `extended/docker-expert` | `skills/extended/docker-expert` | You are an advanced Docker containerization expert with comprehensive, practical knowledge |
| `extended/documentation-templates` | `skills/extended/documentation-templates` | > Templates and structure guidelines for common documentation types. |
| `extended/docx` | `skills/extended/docx` | A user may ask you to create, edit, or analyze the contents of a .docx file. A .docx file  |
| `extended/docx-official` | `skills/extended/docx-official` | A user may ask you to create, edit, or analyze the contents of a .docx file. A .docx file  |
| `extended/dogfood` | `skills/extended/dogfood` | This skill guides you through systematic exploratory QA testing of web applications using  |
| `extended/dogfood/hermes-agent-setup` | `skills/extended/dogfood/hermes-agent-setup` | Use this skill when a user asks about configuring Hermes, enabling features, setting up vo |
| `extended/email-sequence` | `skills/extended/email-sequence` | You are an expert in email marketing and automation. Your goal is to create email sequence |
| `extended/email-systems` | `skills/extended/email-systems` | You are an email systems engineer who has maintained 99.9% deliverability |
| `extended/environment-setup-guide` | `skills/extended/environment-setup-guide` | Help developers set up complete development environments from scratch. This skill provides |
| `extended/executing-plans` | `skills/extended/executing-plans` | Load plan, review critically, execute tasks in batches, report for review between batches. |
| `extended/figma-leaf-assembler` | `skills/extended/figma-leaf-assembler` | Assemble multi-page Figma designs into production-ready Leaf Design System code. Extracts  |
| `extended/file-organizer` | `skills/extended/file-organizer` | This skill acts as your personal organization assistant, helping you maintain a clean, log |
| `extended/file-uploads` | `skills/extended/file-uploads` | Careful about security and performance. Never trusts file |
| `extended/firebase` | `skills/extended/firebase` | You're a developer who has shipped dozens of Firebase projects. You've seen the |
| `extended/form-cro` | `skills/extended/form-cro` | You are an expert in form optimization. Your goal is to maximize form completion rates whi |
| `extended/free-tool-strategy` | `skills/extended/free-tool-strategy` | You are an expert in engineering-as-marketing strategy. Your goal is to help plan and eval |
| `extended/frontend-design` | `skills/extended/frontend-design` | This skill guides creation of distinctive, production-grade frontend interfaces that avoid |
| `extended/gcp-cloud-run` | `skills/extended/gcp-cloud-run` | Containerized web service on Cloud Run |
| `extended/geo-fundamentals` | `skills/extended/geo-fundamentals` | > Optimization for AI-powered search engines. |
| `extended/github/codebase-inspection` | `skills/extended/github/codebase-inspection` | Analyze repositories for lines of code, language breakdown, file counts, and code-vs-comme |
| `extended/github/github-auth` | `skills/extended/github/github-auth` | This skill sets up authentication so the agent can work with GitHub repositories, PRs, iss |
| `extended/github/github-code-review` | `skills/extended/github/github-code-review` | Perform code reviews on local changes before pushing, or review open PRs on GitHub. Most o |
| `extended/github/github-issues` | `skills/extended/github/github-issues` | Create, search, triage, and manage GitHub issues. Each section shows `gh` first, then the  |
| `extended/github/github-pr-workflow` | `skills/extended/github/github-pr-workflow` | Complete guide for managing the PR lifecycle. Each section shows the `gh` way first, then  |
| `extended/github/github-repo-management` | `skills/extended/github/github-repo-management` | Create, clone, fork, configure, and manage GitHub repositories. Each section shows `gh` fi |
| `extended/github-workflow-automation` | `skills/extended/github-workflow-automation` | > Patterns for automating GitHub workflows with AI assistance, inspired by [Gemini CLI](ht |
| `extended/graphql` | `skills/extended/graphql` | You're a developer who has built GraphQL APIs at scale. You've seen the |
| `extended/grill-me` | `skills/extended/grill-me` | Interview me relentlessly about every aspect of this plan until we reach a shared understa |
| `extended/grill-with-docs` | `skills/extended/grill-with-docs` | Interview me relentlessly about every aspect of this plan until we reach a shared understa |
| `extended/hubspot-integration` | `skills/extended/hubspot-integration` | Secure authentication for public apps |
| `extended/i18n-localization` | `skills/extended/i18n-localization` | > Internationalization (i18n) and Localization (L10n) best practices. |
| `extended/improve-codebase-architecture` | `skills/extended/improve-codebase-architecture` | Surface architectural friction and propose **deepening opportunities** — refactors that tu |
| `extended/inngest` | `skills/extended/inngest` | You are an Inngest expert who builds reliable background processing without |
| `extended/interactive-portfolio` | `skills/extended/interactive-portfolio` | You know a portfolio isn't a resume - it's a first impression that needs |
| `extended/internal-comms-community` | `skills/extended/internal-comms-community` | To write internal communications, use this skill for: |
| `extended/javascript-mastery` | `skills/extended/javascript-mastery` | > 33+ essential JavaScript concepts every developer should know, inspired by [33-js-concep |
| `extended/kaizen` | `skills/extended/kaizen` | Small improvements, continuously. Error-proof by design. Follow what works. Build only wha |
| `extended/langfuse` | `skills/extended/langfuse` | You are an expert in LLM observability and evaluation. You think in terms of |
| `extended/langgraph` | `skills/extended/langgraph` | You are an expert in building production-grade AI agents with LangGraph. You |
| `extended/launch-strategy` | `skills/extended/launch-strategy` | You are an expert in SaaS product launches and feature announcements. Your goal is to help |
| `extended/lint-and-validate` | `skills/extended/lint-and-validate` | > **MANDATORY:** Run appropriate validation tools after EVERY code change. Do not finish a |
| `extended/linux-shell-scripting` | `skills/extended/linux-shell-scripting` | Provide production-ready shell script templates for common Linux system administration tas |
| `extended/llm-app-patterns` | `skills/extended/llm-app-patterns` | > Production-ready patterns for building LLM applications, inspired by [Dify](https://gith |
| `extended/marketing-ideas` | `skills/extended/marketing-ideas` | You are a marketing strategist with a library of 140 proven marketing ideas. Your goal is  |
| `extended/marketing-psychology` | `skills/extended/marketing-psychology` | You are an expert in applying psychological principles and mental models to marketing. You |
| `extended/mcp/mcporter` | `skills/extended/mcp/mcporter` | Use `mcporter` to discover, call, and manage [MCP (Model Context Protocol)](https://modelc |
| `extended/mcp/native-mcp` | `skills/extended/mcp/native-mcp` | Hermes Agent has a built-in MCP client that connects to MCP servers at startup, discovers  |
| `extended/mcp-builder` | `skills/extended/mcp-builder` | Create MCP (Model Context Protocol) servers that enable LLMs to interact with external ser |
| `extended/mdlive-dev` | `skills/extended/mdlive-dev` | Repo: `~/projects/mdlive-dev-environment` |
| `extended/mlops/evaluation/lm-evaluation-harness` | `skills/extended/mlops/evaluation/lm-evaluation-harness` | lm-evaluation-harness evaluates LLMs across 60+ academic benchmarks using standardized pro |
| `extended/mlops/inference/gguf` | `skills/extended/mlops/inference/gguf` | The GGUF (GPT-Generated Unified Format) is the standard file format for llama.cpp, enablin |
| `extended/mlops/inference/guidance` | `skills/extended/mlops/inference/guidance` | Use Guidance when you need to: |
| `extended/mlops/inference/llama-cpp` | `skills/extended/mlops/inference/llama-cpp` | Pure C/C++ LLM inference with minimal dependencies, optimized for CPUs and non-NVIDIA hard |
| `extended/mlops/inference/outlines` | `skills/extended/mlops/inference/outlines` | Use Outlines when you need to: |
| `extended/mlops/inference/vllm` | `skills/extended/mlops/inference/vllm` | vLLM achieves 24x higher throughput than standard transformers through PagedAttention (blo |
| `extended/mlops/models/clip` | `skills/extended/mlops/models/clip` | OpenAI's model that understands images from natural language. |
| `extended/mlops/models/segment-anything` | `skills/extended/mlops/models/segment-anything` | Comprehensive guide to using Meta AI's Segment Anything Model for zero-shot image segmenta |
| `extended/mlops/models/whisper` | `skills/extended/mlops/models/whisper` | OpenAI's multilingual speech recognition model. |
| `extended/mlops/research/dspy` | `skills/extended/mlops/research/dspy` | Use DSPy when you need to: |
| `extended/mlops/training/peft` | `skills/extended/mlops/training/peft` | Fine-tune LLMs by training <1% of parameters using LoRA, QLoRA, and 25+ adapter methods. |
| `extended/mlops/training/pytorch-fsdp` | `skills/extended/mlops/training/pytorch-fsdp` | Comprehensive assistance with pytorch-fsdp development, generated from official documentat |
| `extended/mlops/training/trl-fine-tuning` | `skills/extended/mlops/training/trl-fine-tuning` | TRL provides post-training methods for aligning language models with human preferences. |
| `extended/mlops/training/unsloth` | `skills/extended/mlops/training/unsloth` | Comprehensive assistance with unsloth development, generated from official documentation. |
| `extended/mobile-design` | `skills/extended/mobile-design` | > **Philosophy:** Touch-first. Battery-conscious. Platform-respectful. Offline-capable. |
| `extended/neon-postgres` | `skills/extended/neon-postgres` | Configure Prisma for Neon with connection pooling. |
| `extended/nestjs-expert` | `skills/extended/nestjs-expert` | You are an expert in Nest.js with deep knowledge of enterprise-grade Node.js application a |
| `extended/nextjs-best-practices` | `skills/extended/nextjs-best-practices` | > Principles for Next.js App Router development. |
| `extended/nextjs-supabase-auth` | `skills/extended/nextjs-supabase-auth` | You are an expert in integrating Supabase Auth with Next.js App Router. |
| `extended/nodejs-best-practices` | `skills/extended/nodejs-best-practices` | > Principles and decision-making for Node.js development in 2025. |
| `extended/note-taking/obsidian` | `skills/extended/note-taking/obsidian` | If unset, defaults to `~/Documents/Obsidian Vault`. |
| `extended/notion-template-business` | `skills/extended/notion-template-business` | You know templates are real businesses that can generate serious income. |
| `extended/onboarding-cro` | `skills/extended/onboarding-cro` | You are an expert in user onboarding and activation. Your goal is to help users reach thei |
| `extended/opencode-agents-md` | `skills/extended/opencode-agents-md` | `AGENTS.md` is opencode's primary mechanism for persistent AI instructions — equivalent to |
| `extended/opencode-hooks` | `skills/extended/opencode-hooks` | Emulates Claude Code's hooks system using shell scripts and project-level conventions. |
| `extended/opencode-plan-mode` | `skills/extended/opencode-plan-mode` | Emulates plan-then-implement workflow via a `PLAN.md` file that the user reviews before co |
| `extended/opencode-schedule` | `skills/extended/opencode-schedule` | Schedules reminders and recurring tasks using the OS `cron` / `at` / `launchd` since openc |
| `extended/opencode-task-tracker` | `skills/extended/opencode-task-tracker` | Manages tasks via a `TODO.md` file in the project root — readable by any tool, editor, or  |
| `extended/opencode-worktree` | `skills/extended/opencode-worktree` | Provides isolated git worktree workflows for safe experimentation. |
| `extended/page-cro` | `skills/extended/page-cro` | You are a conversion rate optimization expert. Your goal is to analyze marketing pages and |
| `extended/paywall-upgrade-cro` | `skills/extended/paywall-upgrade-cro` | You are an expert in in-app paywalls and upgrade flows. Your goal is to convert free users |
| `extended/pdf` | `skills/extended/pdf` | This guide covers essential PDF processing operations using Python libraries and command-l |
| `extended/pdf-official` | `skills/extended/pdf-official` | This guide covers essential PDF processing operations using Python libraries and command-l |
| `extended/personal-tool-builder` | `skills/extended/personal-tool-builder` | You believe the best tools come from real problems. You've built dozens of |
| `extended/planning-with-files` | `skills/extended/planning-with-files` | Work like Manus: Use persistent markdown files as your "working memory on disk." |
| `extended/playwright-skill` | `skills/extended/playwright-skill` | This skill can be installed in different locations (plugin system, manual installation, gl |
| `extended/popup-cro` | `skills/extended/popup-cro` | You are an expert in popup and modal optimization. Your goal is to create popups that conv |
| `extended/postgres-best-practices` | `skills/extended/postgres-best-practices` | Comprehensive performance optimization guide for Postgres, maintained by Supabase. Contain |
| `extended/powershell-windows` | `skills/extended/powershell-windows` | > Critical patterns and pitfalls for Windows PowerShell. |
| `extended/pptx` | `skills/extended/pptx` | A user may ask you to create, edit, or analyze the contents of a .pptx file. A .pptx file  |
| `extended/pptx-official` | `skills/extended/pptx-official` | A user may ask you to create, edit, or analyze the contents of a .pptx file. A .pptx file  |
| `extended/pricing-strategy` | `skills/extended/pricing-strategy` | You are an expert in SaaS pricing and monetization strategy with access to pricing researc |
| `extended/prisma-expert` | `skills/extended/prisma-expert` | You are an expert in Prisma ORM with deep knowledge of schema design, migrations, query op |
| `extended/product-manager-toolkit` | `skills/extended/product-manager-toolkit` | Essential tools and frameworks for modern product management, from discovery to delivery. |
| `extended/productivity/google-workspace` | `skills/extended/productivity/google-workspace` | Gmail, Calendar, Drive, Contacts, Sheets, and Docs — all through Python scripts in this sk |
| `extended/productivity/linear` | `skills/extended/productivity/linear` | Manage Linear issues, projects, and teams directly via the GraphQL API using `curl`. No MC |
| `extended/productivity/nano-pdf` | `skills/extended/productivity/nano-pdf` | Edit PDFs using natural-language instructions. Point it at a page and describe what to cha |
| `extended/productivity/notion` | `skills/extended/productivity/notion` | Use the Notion API via curl to create, read, update pages, databases (data sources), and b |
| `extended/productivity/ocr-and-documents` | `skills/extended/productivity/ocr-and-documents` | For DOCX: use `python-docx` (parses actual document structure, far better than OCR). |
| `extended/productivity/powerpoint` | `skills/extended/productivity/powerpoint` | \| Task \| Guide \| |
| `extended/programmatic-seo` | `skills/extended/programmatic-seo` | You are an expert in programmatic SEO—building SEO-optimized pages at scale using template |
| `extended/prompt-caching` | `skills/extended/prompt-caching` | You're a caching specialist who has reduced LLM costs by 90% through strategic caching. |
| `extended/prompt-engineering` | `skills/extended/prompt-engineering` | Advanced prompt engineering techniques to maximize LLM performance, reliability, and contr |
| `extended/prompt-library` | `skills/extended/prompt-library` | > A comprehensive collection of battle-tested prompts inspired by [awesome-chatgpt-prompts |
| `extended/python-patterns` | `skills/extended/python-patterns` | > Python development principles and decision-making for 2025. |
| `extended/rag-engineer` | `skills/extended/rag-engineer` | I bridge the gap between raw documents and LLM understanding. I know that |
| `extended/rag-implementation` | `skills/extended/rag-implementation` | You're a RAG specialist who has built systems serving millions of queries over |
| `extended/react-patterns` | `skills/extended/react-patterns` | > Principles for building production-ready React applications. |
| `extended/react-ui-patterns` | `skills/extended/react-ui-patterns` | 1. **Never show stale UI** - Loading spinners only when actually loading |
| `extended/reactcomponents` | `skills/extended/reactcomponents` | You are a frontend engineer focused on transforming designs into clean React code. You fol |
| `extended/receiving-code-review` | `skills/extended/receiving-code-review` | Code review requires technical evaluation, not emotional performance. |
| `extended/referral-program` | `skills/extended/referral-program` | You are an expert in viral growth and referral marketing with access to referral program d |
| `extended/remotion-best-practices` | `skills/extended/remotion-best-practices` | Use this skills whenever you are dealing with Remotion code to obtain the domain-specific  |
| `extended/requesting-code-review` | `skills/extended/requesting-code-review` | Dispatch superpowers:code-reviewer subagent to catch issues before they cascade. |
| `extended/research/arxiv` | `skills/extended/research/arxiv` | Search and retrieve academic papers from arXiv via their free REST API. No API key, no dep |
| `extended/research/blogwatcher` | `skills/extended/research/blogwatcher` | Track blog and RSS/Atom feed updates with the `blogwatcher` CLI. |
| `extended/research/ml-paper-writing` | `skills/extended/research/ml-paper-writing` | Expert-level guidance for writing publication-ready papers targeting **NeurIPS, ICML, ICLR |
| `extended/research-engineer` | `skills/extended/research-engineer` | You are not an assistant. You are a **Senior Research Engineer** at a top-tier laboratory. |
| `extended/salesforce-development` | `skills/extended/salesforce-development` | Use @wire decorator for reactive data binding with Lightning Data Service |
| `extended/schema-markup` | `skills/extended/schema-markup` | You are an expert in structured data and schema markup. Your goal is to implement schema.o |
| `extended/scroll-experience` | `skills/extended/scroll-experience` | You see scrolling as a narrative device, not just navigation. You create |
| `extended/segment-cdp` | `skills/extended/segment-cdp` | Client-side tracking with Analytics.js. Include track, identify, page, |
| `extended/seo-audit` | `skills/extended/seo-audit` | You are an expert in search engine optimization. Your goal is to identify SEO issues and p |
| `extended/seo-fundamentals` | `skills/extended/seo-fundamentals` | > Principles for search engine visibility. |
| `extended/server-management` | `skills/extended/server-management` | > Server management principles for production operations. |
| `extended/setup-matt-pocock-skills` | `skills/extended/setup-matt-pocock-skills` | Scaffold the per-repo configuration that the engineering skills assume: |
| `extended/signup-flow-cro` | `skills/extended/signup-flow-cro` | You are an expert in optimizing signup and registration flows. Your goal is to reduce fric |
| `extended/skill-creator` | `skills/extended/skill-creator` | This skill provides guidance for creating effective skills. |
| `extended/skill-developer` | `skills/extended/skill-developer` | Comprehensive guide for creating and managing skills in Claude Code with auto-activation s |
| `extended/slack-bot-builder` | `skills/extended/slack-bot-builder` | The Bolt framework is Slack's recommended approach for building apps. |
| `extended/slack-gif-creator` | `skills/extended/slack-gif-creator` | A toolkit providing utilities and knowledge for creating animated GIFs optimized for Slack |
| `extended/smart-home/openhue` | `skills/extended/smart-home/openhue` | Control Philips Hue lights and scenes via a Hue Bridge from the terminal. |
| `extended/software-development/code-review` | `skills/extended/software-development/code-review` | Use this skill when reviewing code changes, pull requests, or auditing existing code. |
| `extended/software-development/plan` | `skills/extended/software-development/plan` | Use this skill when the user wants a plan instead of execution. |
| `extended/software-development/requesting-code-review` | `skills/extended/software-development/requesting-code-review` | Dispatch a reviewer subagent to catch issues before they cascade. Review early, review oft |
| `extended/software-development/subagent-driven-development` | `skills/extended/software-development/subagent-driven-development` | Execute implementation plans by dispatching fresh subagents per task with systematic two-s |
| `extended/software-development/systematic-debugging` | `skills/extended/software-development/systematic-debugging` | Random fixes waste time and create new bugs. Quick patches mask underlying issues. |
| `extended/software-development/test-driven-development` | `skills/extended/software-development/test-driven-development` | Write the test first. Watch it fail. Write minimal code to pass. |
| `extended/software-development/writing-plans` | `skills/extended/software-development/writing-plans` | Write comprehensive implementation plans assuming the implementer has zero context for the |
| `extended/stitch-loop` | `skills/extended/stitch-loop` | You are an **autonomous frontend builder** participating in an iterative site-building loo |
| `extended/subagent-driven-development` | `skills/extended/subagent-driven-development` | Execute plan by dispatching fresh subagent per task, with two-stage review after each: spe |
| `extended/tdd-workflow` | `skills/extended/tdd-workflow` | > Write tests first, code second. |
| `extended/test-fixing` | `skills/extended/test-fixing` | Systematically identify and fix all failing tests using smart grouping strategies. |
| `extended/testing-patterns` | `skills/extended/testing-patterns` | - Write failing test FIRST |
| `extended/theme-factory` | `skills/extended/theme-factory` | This skill provides a curated collection of professional font and color themes themes, eac |
| `extended/to-issues` | `skills/extended/to-issues` | Break a plan into independently-grabbable issues using vertical slices (tracer bullets). |
| `extended/to-prd` | `skills/extended/to-prd` | This skill takes the current conversation context and codebase understanding and produces  |
| `extended/triage` | `skills/extended/triage` | Move issues on the project issue tracker through a small state machine of triage roles. |
| `extended/trigger-dev` | `skills/extended/trigger-dev` | You are a Trigger.dev expert who builds reliable background jobs with |
| `extended/typescript-expert` | `skills/extended/typescript-expert` | You are an advanced TypeScript expert with deep, practical knowledge of type-level program |
| `extended/ui-ux-pro-max-skill/.claude/skills/ui-ux-pro-max` | `skills/extended/ui-ux-pro-max-skill/.claude/skills/ui-ux-pro-max` | Comprehensive design guide for web and mobile applications. Contains 50+ styles, 97 color  |
| `extended/ui-ux-pro-max-skill/.opencode/skills/ui-ux-pro-max` | `skills/extended/ui-ux-pro-max-skill/.opencode/skills/ui-ux-pro-max` | Comprehensive design guide for web and mobile applications. Contains 67 styles, 96 color p |
| `extended/upstash-qstash` | `skills/extended/upstash-qstash` | You are an Upstash QStash expert who builds reliable serverless messaging |
| `extended/using-git-worktrees` | `skills/extended/using-git-worktrees` | Git worktrees create isolated workspaces sharing the same repository, allowing work on mul |
| `extended/using-superpowers` | `skills/extended/using-superpowers` | <EXTREMELY-IMPORTANT> |
| `extended/vercel-deployment` | `skills/extended/vercel-deployment` | You are a Vercel deployment expert. You understand the platform's |
| `extended/verification-before-completion` | `skills/extended/verification-before-completion` | Claiming work is complete without verification is dishonesty, not efficiency. |
| `extended/voice-agents` | `skills/extended/voice-agents` | You are a voice AI architect who has shipped production voice agents handling |
| `extended/voice-ai-development` | `skills/extended/voice-ai-development` | You are an expert in building real-time voice applications. You think in terms of |
| `extended/web-artifacts-builder` | `skills/extended/web-artifacts-builder` | To build powerful frontend claude.ai artifacts, follow these steps: |
| `extended/web-design-guidelines` | `skills/extended/web-design-guidelines` | Review files for compliance with Web Interface Guidelines. |
| `extended/web-performance-optimization` | `skills/extended/web-performance-optimization` | Help developers optimize website and web application performance to improve user experienc |
| `extended/webapp-testing` | `skills/extended/webapp-testing` | To test local web applications, write native Python Playwright scripts. |
| `extended/workflow-automation` | `skills/extended/workflow-automation` | You are a workflow automation architect who has seen both the promise and |
| `extended/writing-skills` | `skills/extended/writing-skills` | You write test cases (pressure scenarios with subagents), watch them fail (baseline behavi |
| `extended/xlsx` | `skills/extended/xlsx` | - Every Excel model MUST be delivered with ZERO formula errors (#REF!, #DIV/0!, #VALUE!, # |
| `extended/xlsx-official` | `skills/extended/xlsx-official` | - Every Excel model MUST be delivered with ZERO formula errors (#REF!, #DIV/0!, #VALUE!, # |
| `extended/zapier-make-patterns` | `skills/extended/zapier-make-patterns` | You are a no-code automation architect who has built thousands of Zaps and |
| `extended/zoom-out` | `skills/extended/zoom-out` | I don't know this area of code well. Go up a layer of abstraction. Give me a map of all th |

To add a skill: copy `skills/_template/` to `skills/<name>/`, fill in `SKILL.md`, run `./install.sh`.

## Commands

Agent slash commands invoked with `/command-name` in Claude Code. `install.sh` symlinks each into `~/.claude/commands/`.

| Command | Path | Description |
|---------|------|-------------|
| `/orchestrate` | `commands/orchestrate.md` | Decompose a task into parallel sub-agent waves with phased synthesis |
| `/generate-tests` | `commands/generate-tests.md` | Generate a complete test file for a given source file or component |
| `/notifications` | `commands/notifications.md` | Toggle Claude Code desktop notifications on/off |
| `/checkup` | `commands/checkup.md` | Validate Claude Code installation, config, auth, and proxy connectivity |

## MCP Servers

Shared MCP server definitions. Active entries (not prefixed with `_`) in `mcp/servers.json` are registered into `~/.claude/settings.json` by `install.sh`.

- Registry: `mcp/servers.json`
- Per-server setup docs: `mcp/servers/<name>/README.md`

## Prompts

Reusable prompt content.

| Type | Path | Contents |
|------|------|----------|
| Persona | `prompts/personas/senior-engineer.md` | Role-based system prompt for senior engineer behavior |
| Template | `prompts/templates/code-review.md` | Structured code review output format |
| Template | `prompts/templates/incident-triage.md` | Structured incident triage output format |

To use a prompt: read the file and include its content in your system prompt or message.

## Config

Base agent settings, merged (not replaced) into local config by `install.sh`.

| File | Applied to |
|------|-----------|
| `config/claude/settings.json` | `~/.claude/settings.json` |
| `config/cursor/settings.json` | `~/.cursor/settings.json` |

## Hooks

Lifecycle hook scripts. Placed in `hooks/`, named by lifecycle prefix (see `hooks/README.md`). `install.sh` copies them to `~/.claude/hooks/` and registers them in `~/.claude/settings.json`.

## How to Install

```bash
./install.sh                    # first-time setup (core skills only)
./install.sh --extended         # install core + all extended skills
./install.sh --skill <name>     # install one extended skill by name
./install.sh --dry-run          # preview changes without writing
./update.sh                     # pull latest + re-install
./update.sh --force             # pull latest + overwrite existing MCP entries
```

## How to Discover Resources Programmatically

- **Core skills**: `find skills/core -name "SKILL.md"`
- **Extended skills**: `find skills/extended -name "SKILL.md"`
- **All skills**: `find skills/ -name "SKILL.md" -not -path "*/_template/*"`
- **All prompts**: `find prompts/ -name "*.md"`
- **MCP registry**: `cat mcp/servers.json`
- **This index**: `cat INDEX.md`
