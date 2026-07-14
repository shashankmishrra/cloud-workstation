# Cloud Workstation

> Infrastructure as Code for a reproducible Ubuntu development workstation.

Cloud Workstation provisions a fresh Ubuntu machine into a fully configured, remote-accessible development environment that is ready to run Hermes.

The goal is simple:

```
Fresh Ubuntu
      │
      ▼
Run bootstrap.sh
      │
      ▼
Desktop
RustDesk
Browsers
Docker
Mise
      │
      ▼
Hermes Ready
```

Cloud Workstation is responsible only for the operating system and development environment.

Once Hermes is installed, Hermes becomes responsible for developer tooling, AI agents, workflows, shell customization, project management, and daily operations.

---

# Vision

A development workstation should be:

* Reproducible
* Automated
* Version controlled
* Recoverable
* Consistent
* Disposable

No workstation should rely on undocumented manual configuration.

A brand-new Lightsail instance should become production-ready by executing the bootstrap process.

---

# Project Status

Current Version

```
v0.1
```

Status

```
Under Active Development
```

Target Platform

* Ubuntu 24.04 LTS
* AWS Lightsail

---

# Architecture

```
                    Cloud Workstation

                     bootstrap.sh
                           │
                           ▼
                  Component Orchestrator
                           │
        ┌──────────────────┼──────────────────┐
        ▼                  ▼                  ▼

     System            Desktop           RustDesk

        ▼                  ▼                  ▼

     Browsers          Docker              Mise

                           ▼

                        Hermes
```

---

# Responsibilities

Cloud Workstation owns:

* Operating system setup
* Desktop environment
* Remote desktop
* Networking
* Browser installation
* Docker
* Docker Compose
* Mise
* Base runtime

Cloud Workstation does NOT own:

* Claude Code
* AI CLIs
* Dotfiles
* Shell customization
* Git configuration
* SSH configuration
* Development workflow
* Project templates
* Business automation

Those belong to Hermes.

---

# Repository Structure

```
cloud-workstation/

bootstrap.sh

components/
    system/
    desktop/
    rustdesk/
    browsers/
    docker/
    mise/
    hermes/

configs/
    components.conf
    packages/

docs/

lib/
```

---

# Components

## System

Responsibilities

* Update package index
* Install base packages
* Verify installation

---

## Desktop

Responsibilities

* Install XFCE
* Install LightDM
* Configure desktop environment

---

## RustDesk

Responsibilities

* Install RustDesk
* Configure firewall
* Verify service
* Diagnostics

---

## Browsers

Responsibilities

* Install Google Chrome
* Install Firefox

---

## Docker

Responsibilities

* Install Docker Engine
* Install Docker Compose Plugin
* Configure Docker service
* Configure non-root access

---

## Mise

Responsibilities

* Install Mise
* Configure shell
* Install project toolchain

---

## Hermes

Responsibilities

* Clone Hermes
* Bootstrap Hermes

After this point Cloud Workstation's responsibility ends.

---

# Bootstrap Process

```
bootstrap.sh

↓

Load libraries

↓

Read component manifest

↓

Run components sequentially

↓

Each component

Install

↓

Verify

↓

Continue

↓

Complete
```

---

# Configuration

The repository is configuration-driven.

## Component Order

```
configs/components.conf
```

Controls which components are executed and in what order.

---

## Package Lists

```
configs/packages/
```

Each component owns its package definitions.

Example

```
configs/packages/system.txt
configs/packages/desktop.txt
configs/packages/docker.txt
```

Installers read these files instead of hardcoding package names.

---

# Installation

Clone the repository

```bash
git clone <repository-url>
cd cloud-workstation
```

Run

```bash
./bootstrap.sh
```

The bootstrap process will execute every enabled component in order.

---

# Verification

Each component exposes its own verification script.

Example

```bash
./components/system/verify.sh

./components/docker/verify.sh

./components/mise/verify.sh
```

Verification scripts should always be safe to run repeatedly.

---

# Development Workflow

When adding a new component:

1. Create the component directory.
2. Implement `install.sh`.
3. Implement `verify.sh`.
4. Add configuration files if required.
5. Register the component in `configs/components.conf`.
6. Test on a clean machine.
7. Commit changes.

Every component must be idempotent.

Running installers multiple times must never break the workstation.

---

# Design Principles

## Infrastructure as Code

Every manual step should eventually become code.

---

## Idempotency

Running installers multiple times should produce the same result.

---

## Configuration over Hardcoding

Configuration belongs in `configs/`.

Logic belongs in `components/`.

---

## Small Components

Each component owns one responsibility.

Avoid large installation scripts.

---

## Version Control

Everything required to reproduce the workstation should live in Git.

---

## Reproducibility

The ultimate goal is:

1. Launch a new Ubuntu instance.
2. Clone this repository.
3. Execute `bootstrap.sh`.
4. Obtain a fully configured workstation.

---

# Maintenance

When adding software:

1. Decide whether it belongs to Cloud Workstation or Hermes.
2. If it is operating-system or runtime infrastructure, add it here.
3. If it is developer tooling or workflow automation, add it to Hermes.

Avoid mixing responsibilities.

---

# Recovery

Recovery process:

1. Provision a new Ubuntu instance.
2. Clone this repository.
3. Run `bootstrap.sh`.
4. Verify components.
5. Clone Hermes.
6. Bootstrap Hermes.
7. Resume development.

No manual configuration should be required.

---

# Roadmap

## v0.1

* Repository foundation
* Bootstrap engine
* System
* Desktop
* RustDesk
* Browsers
* Docker
* Mise

## v1.0

* Hermes bootstrap
* Fresh machine validation
* Recovery documentation
* Lightsail base snapshot

---

# Contributing

Before submitting changes:

* Keep components independent.
* Do not introduce hidden dependencies.
* Keep installers idempotent.
* Keep verification scripts reliable.
* Prefer configuration over hardcoded values.
* Test on a clean Ubuntu instance whenever possible.

---

# License

This project is licensed under the MIT License.

---

# Long-Term Vision

Cloud Workstation is the foundation of the Createahead engineering platform.

Its purpose is not to become a complete developer environment.

Its purpose is to reliably provision the operating system and core infrastructure so that Hermes can take over and manage everything above it.

This separation keeps responsibilities clear, simplifies maintenance, and ensures every new workstation can be created, recovered, or replaced in a predictable and repeatable manner.
