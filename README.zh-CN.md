# Claude Code项目模板

**语言切换**: [English](README.md) | [中文](README.zh-CN.md)

一个专为 Claude Code 工作流程设计的结构化项目模板，包含全面的文档和开发过程管理。

> 此模板也适用于其他 AI-IDE 扩展，如 Cline, Tongyi Lingma等, 但目前测试效果在Claude Code 和 Cursor中效果较好。

## 此模板提供的内容

- **CLAUDE.md 配置** - 预配置的 Claude Code 交互指导文件
- **.claude/commands** - 预配置的 Claude Code 交互命令
- **文档结构** - 组织化的文档系统，用于需求、技术设计和进度跟踪
- **开发日志** - 记录开发任务和决策的结构化方法
- **项目记忆管理** - 维护长期项目上下文和进度的系统

## 模板结构

```
├── CLAUDE.md                    # Claude Code 配置和说明
├── .claude/commands/            # 预配置的 Claude Code 交互命令
├── spec/
│   ├── requirements.md          # 项目需求和设计
│   ├── tech-design.md           # 技术架构文档
│   ├── development-progress.md  # 进度跟踪和任务管理
│   └── develop-logs/            # 个人开发任务日志
└── README.md                    # 项目介绍（此文件）
```

此模板有助于在 Claude Code 项目中保持一致性，并确保重要的开发上下文得到保存和访问。

## 待办事项

- [ ] UI 设计文件管理
- [ ] 需求文件管理

## 如何使用

### 在 Claude Code 中

只需在 Claude Code 中输入 `/`，您就可以看到命令列表，然后按 `Tab` 选择要使用的命令。

### 在 Cursor 或其他 AI-IDE 扩展（如通义灵码）中

在聊天窗口中添加文件内容，然后按照命令用法输入参数内容。
例如，如果您想使用 code-check 命令检查 `src/` 文件夹中的 Python 代码，可以在聊天窗口中输入 `@code-check.md src/`。
