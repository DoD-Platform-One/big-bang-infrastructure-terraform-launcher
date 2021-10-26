# Contributing to big-bang-terraform-launcher

First off, thanks so much for wanting to help out! :tada:

The following is a set of guidelines for contributing to this repo. These are mostly guidelines, not rules. Use your best judgement, and feel free to propose changes to this document in a merge request.

## Developer Experience

Continuous Delivery is core to our development philosophy. Check out [https://minimumcd.org](https://minimumcd.org/) for a good baseline agreement on what that means.

Specifically:

- We do trunk-based development with short-lived feature branches that originate from the trunk, get merged to the trunk, and are deleted after the merge
- We don't merge code into the trunk that isn't releasable
- We perform automated testing on all changes before they get merged to the trunk
- We create immutable release artifacts

### Developer Workflow

Here's what a typical "day in the life" of a developer might look like. Keep in mind that other than things that are required through automation these aren't hard-and-fast rules. When in doubt, the process outlined here works for us.

:key: == Required by automation

1. Pick an outstanding issue to work on and set yourself as the assignee.
1. Write up a rough outline of what you plan to do in the issue so you can get early feedback. Clearly announce any breaking changes you think need to be made.
1. :key: Create a branch off the trunk, or a fork if you don't have the right permissions to push a branch.
1. Create a Draft Merge Request as soon as you are able to, even if it is just 5 minutes after you started working on it. Around here we aren't afraid to show unfinished work. It helps us get feedback more quickly.
1. :key: Create a Merge Request (or mark it Ready for Review if you've been working in a Draft PR).
1. Clearly announce any breaking changes that have been made.
1. :key: Get at least 1 peer-review approval.
1. :key: Merge the MR into the trunk. We tend to prefer "Squash and Merge" but if your commits are on-point and you want to preserve them in the Git history of the trunk that's fine too.
1. Delete the branch
1. Close the issue if it got fully resolved by your MR. *Hint: You can add "Fixes #XX" to the MR description to automatically close an issue when the MR is merged.*

## Testing

This section dives deeper into how we test this repo

### Pre-Commit Hooks and Linting

In this repo we use [pre-commit](https://pre-commit.com/) hooks for automated validation and linting. The CI pipeline will validate that all of the hooks pass so we strongly recommend that you install the hooks locally or you'll be spending a lot of time manually fixing issues that could be fixed automatically very quickly.

#### Pre-Commit Prerequisites

1. Install [pre-commit](https://pre-commit.com/)
1. Install [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
1. Install [terraform-docs](https://github.com/terraform-docs/terraform-docs)
1. Install [tflint](https://github.com/terraform-linters/tflint)
1. Run `pre-commit install` in the repo to install the pre-commit hooks. This will make the hooks run automatically each time you `git commit`. If you want to skip the hooks for any reason you can run `git commit --no-verify` to skip them.

> **HINT:** *Consider [automatically enabling the hooks in every Git repository](https://pre-commit.com/#automatically-enabling-pre-commit-on-repositories)*

### End2End Testing

We don't do any E2E testing yet, but we want to. We plan to use [Terratest](https://terratest.gruntwork.io/). If this is something you are interested in let us know, we'll provide the AWS account to do the tests in.
