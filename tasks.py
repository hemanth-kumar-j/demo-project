"""Task automation using Invoke for Robot Framework tests."""

from invoke import task
import os

DEFAULT_EXPANDS = [
    "name:SeleniumLibrary.Capture Page Screenshot",
    "name:SeleniumLibrary.Capture Element Screenshot",
    "name:Builtin.Log",
    "name:Screenshot.Take Screenshot",
]

RESULTS_DIR = "Results"


@task
def test(c, t=None):
    """Run Robot Framework tests with default expands."""
    os.makedirs(RESULTS_DIR, exist_ok=True)  # Ensure Results directory exists
    expand_options = " ".join(
        [f'--expandkeywords "{expand}"' for expand in DEFAULT_EXPANDS]
    )
    tag_option = f'-i "{t}"' if t else ""
    c.run(
        f"robot --consolecolors on -d {RESULTS_DIR} {expand_options} {tag_option} demo.robot",
        pty=True,
    )


@task
def clean(c):
    """Remove log files and reports."""
    c.run("rm -rf {RESULTS_DIR} output.xml report.html log.html")


@task
def run_test_name(c, test_name):
    """Run a specific Robot Framework test with default expands."""
    os.makedirs(RESULTS_DIR, exist_ok=True)  # Ensure Results directory exists
    expand_options = " ".join(
        [f'--expandkeywords "{expand}"' for expand in DEFAULT_EXPANDS]
    )
    c.run(
        f'robot --consolecolors on -d {RESULTS_DIR} {expand_options} -t "{test_name}" demo.robot',
        pty=True,
    )
