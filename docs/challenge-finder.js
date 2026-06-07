window.SQL_CHALLENGES = [
  { id: "001", title: "Passenger survival by class", folder: "001_passenger_survival", skill: "foundations", difficulty: "starter", focus: "Grouping, rates, and segmented aggregation." },
  { id: "002", title: "Top customers by total spend", folder: "002_top_customers", skill: "foundations", difficulty: "starter", focus: "Ranking customer totals with window functions." },
  { id: "003", title: "Customer retention", folder: "003_customer_retention", skill: "retention", difficulty: "starter", focus: "Repeat customers by month." },
  { id: "004", title: "Cohort retention", folder: "004_cohort_retention", skill: "retention", difficulty: "intermediate", focus: "Cohort offsets and activity rates." },
  { id: "005", title: "Daily revenue", folder: "005_daily_revenue", skill: "revenue", difficulty: "starter", focus: "Time-based revenue aggregation." },
  { id: "006", title: "Funnel conversion rates", folder: "006_funnel_conversion", skill: "behavior", difficulty: "starter", focus: "Event funnel counts and conversion rates." },
  { id: "007", title: "Category revenue share", folder: "007_category_revenue_share", skill: "revenue", difficulty: "starter", focus: "Percent-of-total analysis by category." },
  { id: "008", title: "Daily revenue with missing dates", folder: "008_daily_revenue_date_spine", skill: "revenue", difficulty: "intermediate", focus: "Date spines and rolling windows." },
  { id: "009", title: "Top products per category", folder: "009_top_products_per_category", skill: "foundations", difficulty: "intermediate", focus: "Top-N ranking within groups." },
  { id: "010", title: "Customer LTV", folder: "010_customer_ltv", skill: "foundations", difficulty: "starter", focus: "Customer-level spend, order count, and rank." },
  { id: "011", title: "Pareto customers", folder: "011_pareto_customers", skill: "revenue", difficulty: "intermediate", focus: "Revenue concentration and cumulative share." },
  { id: "012", title: "Product return rate", folder: "012_product_return_rate", skill: "behavior", difficulty: "starter", focus: "Product quality metrics from orders and returns." },
  { id: "013", title: "Monthly revenue growth", folder: "013_monthly_revenue_growth", skill: "revenue", difficulty: "intermediate", focus: "Month-over-month revenue change." },
  { id: "014", title: "Category monthly growth", folder: "014_category_monthly_growth", skill: "revenue", difficulty: "intermediate", focus: "Month-over-month growth by category." },
  { id: "015", title: "Sessionization", folder: "015_sessionization", skill: "behavior", difficulty: "advanced", focus: "Session boundaries from event timestamps." },
  { id: "016", title: "Monthly median order value", folder: "016_monthly_median_order_value", skill: "revenue", difficulty: "advanced", focus: "Median calculations with SQLite windows." },
  { id: "017", title: "Longest purchase streak", folder: "017_longest_purchase_streak", skill: "behavior", difficulty: "advanced", focus: "Gap-and-islands logic for consecutive months." },
  { id: "018", title: "Time to repeat purchase", folder: "018_time_to_repeat", skill: "behavior", difficulty: "intermediate", focus: "First and second order timing." },
  { id: "019", title: "Repeat purchase within 30 days", folder: "019_repeat_within_30d_cohort", skill: "retention", difficulty: "intermediate", focus: "Cohort repeat rates with a time window." },
  { id: "020", title: "Retention matrix", folder: "020_retention_matrix", skill: "retention", difficulty: "advanced", focus: "Cohort month by age matrix output." },
  { id: "021", title: "Churned customers", folder: "021_churned_customers", skill: "behavior", difficulty: "starter", focus: "Inactive customers based on recent orders." },
  { id: "022", title: "Customer reactivation", folder: "022_customer_reactivation", skill: "behavior", difficulty: "intermediate", focus: "Customers returning after inactivity." },
  { id: "023", title: "Weekly active users", folder: "023_weekly_active_users", skill: "behavior", difficulty: "starter", focus: "Weekly activity counts." },
  { id: "024", title: "RFM segmentation", folder: "024_rfm_segmentation", skill: "behavior", difficulty: "advanced", focus: "Recency, frequency, and monetary quartiles." },
  { id: "025", title: "Signup to first purchase", folder: "025_signup_to_first_purchase", skill: "behavior", difficulty: "intermediate", focus: "Lag from signup to first order." },
  { id: "026", title: "Repeat purchase within 30 days", folder: "026_repeat_purchase_30d", skill: "retention", difficulty: "intermediate", focus: "Repeat purchase rates by cohort." },
  { id: "027", title: "Weekly retention", folder: "027_weekly_retention", skill: "retention", difficulty: "intermediate", focus: "Week-over-week active customer retention." },
  { id: "028", title: "Rolling 7-day active users", folder: "028_rolling_7d_active_users", skill: "retention", difficulty: "advanced", focus: "Date spines, regions, and rolling activity." },
  { id: "029", title: "Cohort weekly retention", folder: "029_cohort_weekly_retention_rolling", skill: "retention", difficulty: "advanced", focus: "Rolling retention averages by cohort." },
  { id: "030", title: "Top customers per month", folder: "030_top_customers_monthly_ties", skill: "revenue", difficulty: "advanced", focus: "Monthly ties, rank changes, and share of revenue." },
  { id: "031", title: "Longest consecutive activity streak", folder: "031_longest_activity_streak", skill: "behavior", difficulty: "advanced", focus: "Gap-and-islands streak detection." },
  { id: "032", title: "Sessionization with inactivity gap", folder: "032_sessionization_30min", skill: "behavior", difficulty: "advanced", focus: "Thirty-minute inactivity session logic." },
  { id: "033", title: "Session funnel conversion", folder: "033_session_funnel_conversion", skill: "behavior", difficulty: "advanced", focus: "Session-level view, cart, and purchase funnels." },
  { id: "034", title: "Reactivation cohorts", folder: "034_reactivation_cohorts", skill: "retention", difficulty: "advanced", focus: "Reactivation after gaps and next-month retention." },
  { id: "035", title: "Subscription renewals and winback", folder: "035_subscription_renewal_winback", skill: "engineering", difficulty: "advanced", focus: "Renewal states, missed renewals, and winbacks." },
  { id: "036", title: "SCD Type 2 customer dimension", folder: "036_scd2_customer_dimension", skill: "engineering", difficulty: "advanced", focus: "History table design and effective dating." },
  { id: "037", title: "Incremental fact upsert", folder: "037_incremental_fact_upsert", skill: "engineering", difficulty: "advanced", focus: "Staging-to-fact insert and update patterns." },
  { id: "038", title: "Inventory stockout risk", folder: "038_inventory_stockout_risk", skill: "engineering", difficulty: "advanced", focus: "Sales velocity, lead time, and inventory risk scoring." },
  { id: "039", title: "Trial to paid conversion", folder: "039_trial_to_paid_conversion", skill: "engineering", difficulty: "advanced", focus: "Cohort conversion windows and new MRR rollups." },
  { id: "040", title: "Revenue leakage audit", folder: "040_revenue_leakage_audit", skill: "engineering", difficulty: "advanced", focus: "Invoice, payment, refund, and exception reconciliation." },
];

const CHALLENGES = window.SQL_CHALLENGES;

window.SQL_SKILL_LABELS = {
  all: "Any skill area",
  foundations: "Analytics foundations",
  retention: "Retention and cohorts",
  revenue: "Revenue and growth",
  behavior: "Product and customer behavior",
  engineering: "Data engineering SQL",
};

const SKILL_LABELS = window.SQL_SKILL_LABELS;

window.SQL_DIFFICULTY_LABELS = {
  all: "Any difficulty",
  starter: "Starter",
  intermediate: "Intermediate",
  advanced: "Advanced",
};

const DIFFICULTY_LABELS = window.SQL_DIFFICULTY_LABELS;

function getChallengeGitHubUrl(challenge) {
  return `https://github.com/Bmowville/sql-mini-challenges/tree/main/challenges/${challenge.folder}`;
}

function getChallengeViewerUrl(challenge) {
  return `challenge.html?id=${encodeURIComponent(challenge.folder)}`;
}

function getMatches(skill, difficulty) {
  return CHALLENGES.filter((challenge) => {
    const skillMatches = skill === "all" || challenge.skill === skill;
    const difficultyMatches = difficulty === "all" || challenge.difficulty === difficulty;
    return skillMatches && difficultyMatches;
  });
}

function renderResults(results, summary, container) {
  container.innerHTML = results
    .map(
      (challenge) => `
        <article class="result-card">
          <div class="result-meta">
            <span>${challenge.id}</span>
            <span>${DIFFICULTY_LABELS[challenge.difficulty]}</span>
          </div>
          <h3>${challenge.title}</h3>
          <p>${challenge.focus}</p>
          <div class="result-footer">
            <span>${SKILL_LABELS[challenge.skill]}</span>
            <a href="${getChallengeViewerUrl(challenge)}">View challenge</a>
          </div>
        </article>
      `
    )
    .join("");
  summary.textContent = `${results.length} ${results.length === 1 ? "match" : "matches"} shown.`;
}

function renderEmpty(summary, container) {
  summary.textContent = "No exact match yet.";
  container.innerHTML = `
    <article class="result-card empty-result">
      <h3>Request a related challenge</h3>
      <p>The roadmap is open for new analytics patterns. Suggest a challenge with the tables, question, and expected output you want to practice.</p>
      <div class="result-footer">
        <span>Contributor idea</span>
        <a href="https://github.com/Bmowville/sql-mini-challenges/issues/new?template=challenge_request.yml">Open request form</a>
      </div>
    </article>
  `;
}

function initChallengeFinder() {
  const finder = document.querySelector("[data-challenge-finder]");
  if (!finder) return;

  const skillFilter = finder.querySelector("#skill-filter");
  const difficultyFilter = finder.querySelector("#difficulty-filter");
  const summary = finder.querySelector("[data-finder-summary]");
  const resultsContainer = finder.querySelector("[data-finder-results]");
  const findButton = finder.querySelector("[data-find-challenges]");
  const randomButton = finder.querySelector("[data-random-challenge]");

  const updateResults = () => {
    const matches = getMatches(skillFilter.value, difficultyFilter.value).slice(0, 6);
    if (matches.length === 0) {
      renderEmpty(summary, resultsContainer);
      return;
    }
    renderResults(matches, summary, resultsContainer);
  };

  findButton.addEventListener("click", updateResults);
  skillFilter.addEventListener("change", updateResults);
  difficultyFilter.addEventListener("change", updateResults);
  randomButton.addEventListener("click", () => {
    const matches = getMatches(skillFilter.value, difficultyFilter.value);
    const pool = matches.length > 0 ? matches : CHALLENGES;
    const challenge = pool[Math.floor(Math.random() * pool.length)];
    renderResults([challenge], summary, resultsContainer);
  });

  updateResults();
}

initChallengeFinder();