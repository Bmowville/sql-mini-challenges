const FILES = [
  { key: "readme", label: "README.md", file: "README.md", format: "markdown" },
  { key: "schema", label: "schema.sql", file: "schema.sql", format: "code" },
  { key: "solution", label: "solution.sql", file: "solution.sql", format: "code" },
  { key: "expected", label: "expected.json", file: "expected.json", format: "code" },
];

const RAW_BASE = "https://raw.githubusercontent.com/Bmowville/sql-mini-challenges/main/challenges";
const GITHUB_BASE = "https://github.com/Bmowville/sql-mini-challenges/tree/main/challenges";

function escapeHtml(value) {
  return value
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

function renderInlineMarkdown(value) {
  return escapeHtml(value)
    .replace(/\[([^\]]+)]\(([^)]+)\)/g, '<a href="$2">$1</a>')
    .replace(/`([^`]+)`/g, "<code>$1</code>")
    .replace(/\*\*([^*]+)\*\*/g, "<strong>$1</strong>");
}

function closeList(html, listType) {
  if (listType) {
    html.push(`</${listType}>`);
  }
  return null;
}

function renderMarkdown(markdown) {
  const html = [];
  const codeLines = [];
  let inCode = false;
  let listType = null;

  for (const line of markdown.split("\n")) {
    if (line.startsWith("```")) {
      if (inCode) {
        html.push(`<pre><code>${escapeHtml(codeLines.join("\n"))}</code></pre>`);
        codeLines.length = 0;
        inCode = false;
      } else {
        listType = closeList(html, listType);
        inCode = true;
      }
      continue;
    }

    if (inCode) {
      codeLines.push(line);
      continue;
    }

    if (line.trim() === "") {
      listType = closeList(html, listType);
      continue;
    }

    if (line.startsWith("# ")) {
      listType = closeList(html, listType);
      html.push(`<h2>${renderInlineMarkdown(line.slice(2))}</h2>`);
      continue;
    }

    if (line.startsWith("## ")) {
      listType = closeList(html, listType);
      html.push(`<h3>${renderInlineMarkdown(line.slice(3))}</h3>`);
      continue;
    }

    if (line.startsWith("- ")) {
      if (listType !== "ul") {
        listType = closeList(html, listType);
        html.push("<ul>");
        listType = "ul";
      }
      html.push(`<li>${renderInlineMarkdown(line.slice(2))}</li>`);
      continue;
    }

    const orderedListMatch = line.match(/^\d+\.\s+(.*)$/);
    if (orderedListMatch) {
      if (listType !== "ol") {
        listType = closeList(html, listType);
        html.push("<ol>");
        listType = "ol";
      }
      html.push(`<li>${renderInlineMarkdown(orderedListMatch[1])}</li>`);
      continue;
    }

    listType = closeList(html, listType);
    html.push(`<p>${renderInlineMarkdown(line)}</p>`);
  }

  closeList(html, listType);
  if (inCode) {
    html.push(`<pre><code>${escapeHtml(codeLines.join("\n"))}</code></pre>`);
  }

  return html.join("\n");
}

function getRequestedChallenge() {
  const params = new URLSearchParams(window.location.search);
  const requested = (params.get("id") || params.get("challenge") || "").trim();
  if (!requested) return window.SQL_CHALLENGES[0];

  return window.SQL_CHALLENGES.find(
    (challenge) => challenge.folder === requested || challenge.id === requested || challenge.folder.startsWith(`${requested}_`)
  );
}

function initChallengeSelect(root, selectedChallenge) {
  const select = root.querySelector("[data-challenge-select]");
  select.innerHTML = window.SQL_CHALLENGES
    .map((challenge) => `<option value="${challenge.folder}">${challenge.id} - ${challenge.title}</option>`)
    .join("");
  select.value = selectedChallenge.folder;
  select.addEventListener("change", () => {
    window.location.href = `challenge.html?id=${encodeURIComponent(select.value)}`;
  });
}

function getFileUrl(challenge, file) {
  return `${RAW_BASE}/${challenge.folder}/${file.file}`;
}

function getRunCommand(challenge) {
  return `cat challenges/${challenge.folder}/schema.sql challenges/${challenge.folder}/solution.sql | sqlite3 -header -column :memory:

Windows CMD:
type challenges\\${challenge.folder}\\schema.sql challenges\\${challenge.folder}\\solution.sql | sqlite3 -header -column :memory:`;
}

async function copyText(value, button) {
  try {
    await navigator.clipboard.writeText(value);
  } catch {
    const textarea = document.createElement("textarea");
    textarea.value = value;
    textarea.setAttribute("readonly", "");
    textarea.style.position = "absolute";
    textarea.style.left = "-9999px";
    document.body.append(textarea);
    textarea.select();
    document.execCommand("copy");
    textarea.remove();
  }

  const original = button.textContent;
  button.textContent = "Copied";
  window.setTimeout(() => {
    button.textContent = original;
  }, 1400);
}

async function loadFile(challenge, file, state) {
  const url = getFileUrl(challenge, file);
  state.status.textContent = `Loading ${file.label}...`;
  state.label.textContent = file.label;
  state.rawLink.href = url;

  try {
    const response = await fetch(url);
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    const text = await response.text();
    state.currentText = text;
    state.content.className = `viewer-content ${file.format === "markdown" ? "viewer-markdown" : "viewer-code"}`;
    state.content.innerHTML = file.format === "markdown"
      ? renderMarkdown(text)
      : `<pre><code>${escapeHtml(text)}</code></pre>`;
    state.status.textContent = `${file.label} loaded.`;
  } catch (error) {
    state.currentText = "";
    state.content.className = "viewer-content viewer-empty";
    state.content.innerHTML = `
      <h3>File could not be loaded</h3>
      <p>Open the challenge folder on GitHub to inspect ${file.label} directly.</p>
    `;
    state.status.textContent = `Could not load ${file.label}.`;
  }
}

function selectTab(key, state) {
  const file = FILES.find((item) => item.key === key) || FILES[0];
  state.tabs.forEach((tab) => {
    tab.setAttribute("aria-selected", String(tab.dataset.fileTab === file.key));
  });
  loadFile(state.challenge, file, state);
}

function renderMissingChallenge(root) {
  root.querySelector("[data-viewer-title]").textContent = "Challenge not found";
  root.querySelector("[data-viewer-focus]").textContent = "Use the finder to choose a validated SQL challenge.";
  root.querySelector("[data-viewer-status]").textContent = "No matching challenge id was provided.";
  root.querySelector("[data-file-content]").innerHTML = `
    <div class="viewer-empty">
      <h3>Pick a challenge from the finder</h3>
      <p>The viewer expects a URL like <code>challenge.html?id=038_inventory_stockout_risk</code>.</p>
      <a class="button primary" href="index.html#challenge-finder">Open Finder</a>
    </div>
  `;
}

function initChallengeViewer() {
  const root = document.querySelector("[data-challenge-viewer]");
  if (!root) return;

  const challenge = getRequestedChallenge();
  if (!challenge) {
    renderMissingChallenge(root);
    return;
  }

  document.title = `${challenge.id} ${challenge.title} | SQL Mini Challenges`;
  root.querySelector("[data-viewer-kicker]").textContent = `Challenge ${challenge.id}`;
  root.querySelector("[data-viewer-title]").textContent = challenge.title;
  root.querySelector("[data-viewer-focus]").textContent = challenge.focus;
  root.querySelector("[data-viewer-id]").textContent = challenge.id;
  root.querySelector("[data-viewer-skill]").textContent = window.SQL_SKILL_LABELS[challenge.skill];
  root.querySelector("[data-viewer-difficulty]").textContent = window.SQL_DIFFICULTY_LABELS[challenge.difficulty];
  root.querySelector("[data-github-link]").href = `${GITHUB_BASE}/${challenge.folder}`;
  root.querySelector("[data-run-command]").textContent = getRunCommand(challenge);
  initChallengeSelect(root, challenge);

  const state = {
    challenge,
    currentText: "",
    status: root.querySelector("[data-viewer-status]"),
    label: root.querySelector("[data-file-label]"),
    rawLink: root.querySelector("[data-raw-link]"),
    content: root.querySelector("[data-file-content]"),
    tabs: [...root.querySelectorAll("[data-file-tab]")],
  };

  state.tabs.forEach((tab) => {
    tab.addEventListener("click", () => selectTab(tab.dataset.fileTab, state));
  });

  root.querySelector("[data-copy-file]").addEventListener("click", (event) => {
    if (state.currentText) {
      copyText(state.currentText, event.currentTarget);
    }
  });

  selectTab("readme", state);
}

initChallengeViewer();