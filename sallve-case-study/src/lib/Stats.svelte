<script>
  import { onMount } from 'svelte';

  onMount(() => {
    const barObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.querySelectorAll('.proof-bar').forEach((bar, i) => {
            setTimeout(() => bar.classList.add('animated'), i * 150);
          });
          barObserver.unobserve(entry.target);
        }
      });
    }, { threshold: 0.3 });

    const panel = document.querySelector('.proof-panel');
    if (panel) barObserver.observe(panel);

    function animateCount(el) {
      const raw = el.dataset.count;
      if (!raw) return;
      const hasM = raw.endsWith('M');
      const hasK = raw.endsWith('k');
      const suffix = hasM ? 'M' : hasK ? 'k' : '';
      const target = parseFloat(raw.replace(/[Mk,]/g, ''));
      const isDecimal = raw.includes('.');
      const useComma = !hasM && !hasK;
      const duration = 2000;
      const startTime = performance.now();

      function tick(now) {
        const progress = Math.min((now - startTime) / duration, 1);
        const eased = 1 - Math.pow(1 - progress, 2);
        const current = target * eased;
        if (isDecimal) {
          el.textContent = current.toFixed(1) + suffix;
        } else if (useComma) {
          el.textContent = Math.round(current).toLocaleString('en-US');
        } else {
          el.textContent = Math.round(current) + suffix;
        }
        if (progress < 1) requestAnimationFrame(tick);
      }
      requestAnimationFrame(tick);
    }

    const countObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.querySelectorAll('.metric-number[data-count]').forEach(el => animateCount(el));
          countObserver.unobserve(entry.target);
        }
      });
    }, { threshold: 0.5 });

    document.querySelectorAll('.campaign-metrics .metric-cell').forEach(cell => countObserver.observe(cell));
  });
</script>

<section class="w-full border-t border-white/10 bg-[#2a0f0f] px-[6vw] py-32">
  <p class="reveal mb-14 text-[0.7rem] font-medium tracking-[0.22em] uppercase text-white/65">Campaign Performance</p>

  <div class="stats-grid grid grid-cols-2 items-start gap-10 max-[900px]:grid-cols-1">

    <div class="proof-panel slide-left rounded-xl border border-white/10 border-l-[3px] border-l-brand-red bg-[#3a1212] px-14 py-12 max-sm:px-6 max-sm:py-8">
      <div class="mb-12 flex flex-wrap items-baseline justify-between gap-4">
        <span class="text-base font-semibold tracking-[0.04em] text-white">Platform Health Indicators</span>
        <span class="text-[0.72rem] tracking-[0.1em] uppercase text-white/65">Benchmarks cleared this campaign</span>
      </div>

      <div class="flex flex-col gap-8">

        <div class="flex flex-col gap-[0.9rem]">
          <div class="flex items-start justify-between">
            <span class="text-[clamp(2rem,3.5vw,3rem)] font-bold tracking-[-0.02em] leading-none text-white">42%</span>
            <span class="proof-check flex items-center gap-[0.35rem] rounded-full border border-brand-cyan/30 bg-brand-cyan/10 px-[0.7rem] py-[0.3rem] text-[0.65rem] font-semibold tracking-[0.1em] uppercase text-brand-cyan whitespace-nowrap">
              <svg width="10" height="10" viewBox="0 0 10 10" fill="none">
                <path d="M1.5 5L4 7.5L8.5 2.5" stroke="#00C8C0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
              Cleared
            </span>
          </div>
          <span class="text-[0.88rem] font-medium tracking-[0.06em] uppercase text-white/65">Participation Rate</span>
          <div class="h-[2px] overflow-hidden rounded-sm bg-white/10">
            <div class="proof-bar h-full w-full rounded-sm" style="background: linear-gradient(to right, #D41719, #00C8C0)"></div>
          </div>
          <span class="text-[0.65rem] text-white/65">Threshold <strong class="font-semibold text-white/50">&gt;35%</strong></span>
        </div>

        <div class="flex flex-col gap-[0.9rem]">
          <div class="flex items-start justify-between">
            <span class="text-[clamp(2rem,3.5vw,3rem)] font-bold tracking-[-0.02em] leading-none text-white">1.8x</span>
            <span class="proof-check flex items-center gap-[0.35rem] rounded-full border border-brand-cyan/30 bg-brand-cyan/10 px-[0.7rem] py-[0.3rem] text-[0.65rem] font-semibold tracking-[0.1em] uppercase text-brand-cyan whitespace-nowrap">
              <svg width="10" height="10" viewBox="0 0 10 10" fill="none">
                <path d="M1.5 5L4 7.5L8.5 2.5" stroke="#00C8C0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
              Cleared
            </span>
          </div>
          <span class="text-[0.88rem] font-medium tracking-[0.06em] uppercase text-white/65">Invite Multiplier</span>
          <div class="h-[2px] overflow-hidden rounded-sm bg-white/10">
            <div class="proof-bar h-full w-full rounded-sm" style="background: linear-gradient(to right, #D41719, #00C8C0)"></div>
          </div>
          <span class="text-[0.65rem] text-white/65">Threshold <strong class="font-semibold text-white/50">&gt;1.3x</strong></span>
        </div>

        <div class="flex flex-col gap-[0.9rem]">
          <div class="flex items-start justify-between">
            <span class="text-[clamp(2rem,3.5vw,3rem)] font-bold tracking-[-0.02em] leading-none text-white">38%</span>
            <span class="proof-check flex items-center gap-[0.35rem] rounded-full border border-brand-cyan/30 bg-brand-cyan/10 px-[0.7rem] py-[0.3rem] text-[0.65rem] font-semibold tracking-[0.1em] uppercase text-brand-cyan whitespace-nowrap">
              <svg width="10" height="10" viewBox="0 0 10 10" fill="none">
                <path d="M1.5 5L4 7.5L8.5 2.5" stroke="#00C8C0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
              Cleared
            </span>
          </div>
          <span class="text-[0.88rem] font-medium tracking-[0.06em] uppercase text-white/65">Return Engagement</span>
          <div class="h-[2px] overflow-hidden rounded-sm bg-white/10">
            <div class="proof-bar h-full w-full rounded-sm" style="background: linear-gradient(to right, #D41719, #00C8C0)"></div>
          </div>
          <span class="text-[0.65rem] text-white/65">Threshold <strong class="font-semibold text-white/50">&gt;25%</strong></span>
        </div>

      </div>
    </div>

    <div class="campaign-metrics slide-right grid grid-cols-2 gap-3 max-sm:grid-cols-1">
      <div class="metric-cell reveal delay-1 rounded-xl border border-white/10 bg-white/[0.03] px-8 py-7">
        <span class="metric-number mb-2 block text-[clamp(1.6rem,2.2vw,2.2rem)] font-bold tracking-[-0.02em] leading-none text-white" data-count="8200">8,200</span>
        <span class="block text-[0.88rem] font-medium tracking-[0.08em] uppercase text-white/65">Total Replies</span>
      </div>
      <div class="metric-cell reveal delay-2 rounded-xl border border-white/10 bg-white/[0.03] px-8 py-7">
        <span class="metric-number mb-2 block text-[clamp(1.6rem,2.2vw,2.2rem)] font-bold tracking-[-0.02em] leading-none text-white" data-count="196k">196k</span>
        <span class="block text-[0.88rem] font-medium tracking-[0.08em] uppercase text-white/65">Votes Cast</span>
      </div>
      <div class="metric-cell reveal delay-3 rounded-xl border border-white/10 bg-white/[0.03] px-8 py-7">
        <span class="metric-number mb-2 block text-[clamp(1.6rem,2.2vw,2.2rem)] font-bold tracking-[-0.02em] leading-none text-white" data-count="1.8M">1.8M</span>
        <span class="block text-[0.88rem] font-medium tracking-[0.08em] uppercase text-white/65">Organic Reach</span>
      </div>
      <div class="metric-cell reveal delay-4 rounded-xl border border-white/10 bg-white/[0.03] px-8 py-7">
        <span class="mb-2 block text-[clamp(1.6rem,2.2vw,2.2rem)] font-bold tracking-[-0.02em] leading-none text-brand-cyan">Silver</span>
        <span class="block text-[0.88rem] font-medium tracking-[0.08em] uppercase text-white/65">Prize Tier — R$8,000</span>
      </div>
      <div class="metric-cell reveal delay-1 rounded-xl border border-white/10 bg-white/[0.03] px-8 py-7">
        <span class="metric-number mb-2 block text-[clamp(1.6rem,2.2vw,2.2rem)] font-bold tracking-[-0.02em] leading-none text-white" data-count="4.1M">4.1M</span>
        <span class="block text-[0.88rem] font-medium tracking-[0.08em] uppercase text-white/65">Total Views</span>
      </div>
      <div class="metric-cell reveal delay-2 rounded-xl border border-white/10 bg-white/[0.03] px-8 py-7">
        <span class="metric-number mb-2 block text-[clamp(1.6rem,2.2vw,2.2rem)] font-bold tracking-[-0.02em] leading-none text-white" data-count="18600">18,600</span>
        <span class="block text-[0.88rem] font-medium tracking-[0.08em] uppercase text-white/65">Campaign Shares</span>
      </div>
    </div>

  </div>
</section>

<style>
  /* Bar animation — can't be expressed in Tailwind */
  .proof-bar {
    transform-origin: left;
    animation: barGrow 1.2s ease forwards;
    animation-play-state: paused;
  }
  .proof-bar:global(.animated) { animation-play-state: running; }
  @keyframes barGrow { from { transform: scaleX(0); } to { transform: scaleX(1); } }
</style>
