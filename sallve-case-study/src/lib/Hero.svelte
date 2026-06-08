<section class="hero">
  <svg width="0" height="0" style="position:absolute">
    <defs>
      <clipPath id="imageClip" clipPathUnits="objectBoundingBox">
        <path d="M 0,0 L 1,0 L 1,1 L 0.38,1 C -0.02,0.65 0.18,0.3 0,0 Z"/>
      </clipPath>
    </defs>
  </svg>

  <img src="/Frame 10.png" alt="" class="hero-bg-image" />
  <div class="hero-fade"></div>
  <div class="hero-glow"></div>
  <div class="hero-noise"></div>

  <nav class="hero-nav">
    <img src="/Group 254.png" alt="DUIU" class="block h-8 w-auto" />
    <span class="rounded-full border border-[rgba(13,11,26,0.15)] px-[0.85rem] py-[0.35rem] text-[0.7rem] font-medium tracking-[0.18em] uppercase text-[rgba(13,11,26,0.45)]">
      Brand Case Study
    </span>
  </nav>

  <div class="hero-content">
    <div class="reveal mb-10 flex items-center gap-4">
      <span class="text-[clamp(1.1rem,2vw,1.4rem)] font-semibold tracking-[0.06em] uppercase text-brand-red">Sallve</span>
      <div class="h-[1.2rem] w-px bg-[rgba(13,11,26,0.2)]"></div>
      <span class="text-[0.8rem] tracking-[0.14em] uppercase text-[rgba(13,11,26,0.45)]">Brazil · 2026</span>
    </div>

    <p class="reveal delay-1 mb-[1.2rem] text-[0.7rem] font-medium tracking-[0.2em] uppercase text-brand-red">Drop Campaign</p>

    <h1 class="reveal delay-2 mb-4 text-[clamp(3rem,7.5vw,7rem)] font-bold leading-none tracking-[-0.02em] text-[#0D0B1A]">
      Sua Pele,<br /><em class="not-italic text-brand-red">Sua Luz.</em>
    </h1>

    <p class="reveal delay-3 mb-12 max-w-130 text-[clamp(0.9rem,1.5vw,1.1rem)] leading-[1.7] text-[rgba(13,11,26,0.6)]">
      Sallve invited Brazil to share their real skincare story. The community showed up, the votes poured in, and a Silver prize tier unlocked in ten days.
    </p>

    <div class="reveal delay-4 flex flex-wrap gap-x-8 gap-y-2">
      <span class="flex items-center gap-2 text-[0.8rem] font-medium tracking-[0.08em] text-[rgba(13,11,26,0.55)]">
        <span class="size-1.25 shrink-0 rounded-full bg-brand-red"></span>14 Days Active
      </span>
      <span class="flex items-center gap-2 text-[0.8rem] font-medium tracking-[0.08em] text-[rgba(13,11,26,0.55)]">
        <span class="size-1.25 shrink-0 rounded-full bg-brand-red"></span>Brazil
      </span>
      <span class="flex items-center gap-2 text-[0.8rem] font-medium tracking-[0.08em] text-[rgba(13,11,26,0.55)]">
        <span class="size-1.25 shrink-0 rounded-full bg-brand-red"></span>Silver Prize Tier — R$8,000
      </span>
      <span class="flex items-center gap-2 text-[0.8rem] font-medium tracking-[0.08em] text-[rgba(13,11,26,0.55)]">
        <span class="size-1.25 shrink-0 rounded-full bg-brand-red"></span>1.8M Organic Reach
      </span>
    </div>
  </div>

  <div class="absolute bottom-10 left-1/2 flex -translate-x-1/2 flex-col items-center gap-2 opacity-30">
    <div class="scroll-line"></div>
  </div>
</section>

<style>
  /* Kept here: clip-path, radial gradients, keyframe animations — not expressible in Tailwind */
  .hero {
    position: relative;
    min-height: 100vh;
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    overflow: hidden;
    padding: 0 6vw;
    background: #FFFFFF;
  }
  .hero-bg-image {
    position: absolute; right: 0; top: 0;
    height: 100%; width: auto;
    clip-path: url(#imageClip);
    pointer-events: none;
  }
  .hero-fade {
    position: absolute; inset: 0;
    background: linear-gradient(to right, rgba(255,255,255,0) 30%, rgba(255,255,255,0.65) 48%, rgba(255,255,255,0) 64%);
    pointer-events: none;
  }
  .hero-glow {
    position: absolute; inset: 0;
    background:
      radial-gradient(ellipse 65% 60% at 25% 45%, rgba(212,23,25,0.40) 0%, transparent 68%),
      radial-gradient(ellipse 50% 50% at 8%  78%, rgba(170,10,12,0.30) 0%, transparent 60%),
      radial-gradient(ellipse 40% 40% at 42% 18%, rgba(0,180,172,0.16) 0%, transparent 55%);
    pointer-events: none;
  }
  .hero-noise {
    position: absolute; inset: 0; opacity: 0.03;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)'/%3E%3C/svg%3E");
    background-repeat: repeat; background-size: 128px 128px;
    pointer-events: none;
  }
  .hero-nav {
    position: absolute; top: 0; left: 0; right: 0;
    display: flex; align-items: center; justify-content: space-between;
    padding: 2rem 6vw;
  }
  .hero-content {
    position: relative; z-index: 2;
    max-width: 560px; padding-top: 8rem; padding-bottom: 6rem;
  }
  .scroll-line {
    width: 1px; height: 48px;
    background: linear-gradient(to bottom, #0D0B1A, transparent);
    animation: scrollPulse 2s ease-in-out infinite;
  }
  @keyframes scrollPulse { 0%, 100% { opacity: 0.3; } 50% { opacity: 0.9; } }

  @media (max-width: 700px) {
    .hero-content { max-width: 100%; }
    .hero-fade { background: linear-gradient(to bottom, rgba(255,255,255,0) 40%, rgba(255,255,255,0.8) 65%, #FFFFFF 82%); }
  }
</style>
