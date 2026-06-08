<script>
  import Blurhash from './Blurhash.svelte';

  const blurhash = '^EA[lu9^5l$%WCs.67$%niWVj[S25;$h,=NdoJjt}AEhOEoKNbxFM{xFJ.$ismNb5Rs.-BEgxFWVs9Nb$%fkJ8xFjFxGEg$hs:NbxaWVjYNbxFbH|';

  const videos = [
    {
      src: 'https://cdn-prod.mono-digital.com/challenges/01967e0e-b55d-7ee8-a567-d57d1a643174/contributions/01967e96-abb7-72f1-983c-063ce448db49/2407640b-c2f3-4ec5-9073-3778dd61d408.mp4',
      label: '#2 Best Reply',
      sublabel: 'Runner up',
    },
    {
      src: 'https://cdn-prod.mono-digital.com/challenges/0199ba58-0d43-7251-a750-b85f9be2b09e/contributions/0199ba82-453d-7732-9c42-42917153ad10/cc70c5dc-422e-48bd-b77b-b2ec9f0c7d2c.mp4',
      label: 'Winner',
      sublabel: 'Most voted Reply',
    },
    {
      src: 'https://cdn-prod.mono-digital.com/challenges/0199ba58-0d43-7251-a750-b85f9be2b09e/contributions/0199bb2f-0ac4-745f-a6fa-ab0ca3423e2c/3989384c-9bba-48b0-9050-00ba8eeffbba.mp4',
      label: '#3 Best Reply',
      sublabel: 'Runner up',
    },
  ];
</script>

<section class="featured-video">
  <div class="blurhash-bg">
    <Blurhash hash={blurhash} width={32} height={32} />
  </div>

  <img src="/Bg pattern.png" alt="" class="bg-pattern" />

  <div class="glow-dots"></div>

  <div class="phones-row">
    {#each videos as video}
      <div class="phone-slot">
        <div class="phone-frame">
          <div class="phone-screen">
            <video src={video.src} autoplay muted loop playsinline></video>
          </div>
        </div>
        <div class="phone-caption">
          <span class="phone-label">{video.label}</span>
          <span class="phone-sublabel">{video.sublabel}</span>
        </div>
      </div>
    {/each}
  </div>

  <div class="featured-meta">
    <span class="featured-tag">Top Replies from the Drop</span>
    <p class="featured-headline">8,200 creators. One community.<br />These are the videos Brazil voted to the top.</p>
    <p class="featured-desc">Every Reply was filmed, shared and voted on entirely by the community — no scripts, no casting, no paid reach. Just real people and real results.</p>
  </div>
</section>

<style>
  .featured-video {
    position: relative;
    width: 100%;
    background: #FFFFFF;
    border-top: 1px solid var(--border);
    padding: 4rem 6vw;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 3rem;
    overflow: hidden;
  }

  .glow-dots {
    position: absolute;
    inset: 0;
    pointer-events: none;
    z-index: 1;
    background:
      radial-gradient(ellipse 30% 50% at 12% 55%, rgba(212, 23, 25, 0.25) 0%, transparent 70%),
      radial-gradient(ellipse 30% 50% at 88% 55%, rgba(0, 200, 192, 0.20) 0%, transparent 70%);
  }

  .bg-pattern {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 100%;
    height: 100%;
    object-fit: cover;
    z-index: 1;
    pointer-events: none;
  }

  .bg-image {
    position: absolute;
    top: 0;
    left: 0;
    width: auto;
    height: 100%;
    z-index: 0;
    pointer-events: none;
  }

  .blurhash-bg {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
  }

  .blurhash-bg :global(canvas) {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    filter: blur(40px);
    transform: scale(1.2);
    opacity: 0.35;
  }

  .phone-slot {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1rem;
    background: linear-gradient(
      160deg,
      rgba(255, 255, 255, 0.55) 0%,
      rgba(255, 255, 255, 0.08) 40%,
      rgba(255, 255, 255, 0.12) 100%
    );
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-radius: 24px;
    padding: 2rem 2rem 1.6rem;
    border: 1px solid rgba(255, 255, 255, 0.5);
    border-top-color: rgba(255, 255, 255, 0.95);
    border-left-color: rgba(255, 255, 255, 0.7);
    box-shadow:
      0 12px 40px rgba(0, 0, 0, 0.12),
      0 2px 8px rgba(0, 0, 0, 0.06),
      inset 0 1px 0 rgba(255, 255, 255, 1),
      inset 1px 0 0 rgba(255, 255, 255, 0.6),
      inset 0 -1px 0 rgba(255, 255, 255, 0.15);
  }

  .phone-caption {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.25rem;
    text-align: center;
  }

  .phone-label {
    font-size: 1.05rem;
    font-weight: 700;
    letter-spacing: 0.04em;
    color: #0D0B1A;
  }

  .phone-sublabel {
    font-size: 0.82rem;
    font-weight: 500;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    color: rgba(13, 11, 26, 0.5);
  }

  .phones-row {
    position: relative;
    z-index: 1;
    display: flex;
    align-items: flex-end;
    gap: 4rem;
  }

  .phone-frame {
    width: 260px;
    background: #111;
    border-radius: 44px;
    padding: 10px;
    overflow: hidden;
    box-shadow:
      0 0 0 1px #333,
      0 40px 100px rgba(0, 0, 0, 0.5),
      inset 0 0 0 1px #444;
  }

  .phone-screen {
    position: relative;
    border-radius: 32px;
    overflow: hidden;
    aspect-ratio: 9 / 19.5;
    background: #000;
  }

  .phone-screen video {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }

  .featured-meta {
    position: relative;
    z-index: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1rem;
    max-width: 700px;
    text-align: center;
  }

  .featured-tag {
    font-size: 0.65rem;
    font-weight: 600;
    letter-spacing: 0.2em;
    text-transform: uppercase;
    color: var(--cyan);
    border: 1px solid rgba(0, 200, 192, 0.3);
    background: rgba(0, 200, 192, 0.08);
    padding: 0.35rem 0.9rem;
    border-radius: 100px;
  }

  .featured-headline {
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: clamp(1.6rem, 3vw, 2.6rem);
    font-weight: 700;
    line-height: 1.2;
    letter-spacing: -0.02em;
    color: #0D0B1A;
    text-align: center;
  }

  .featured-desc {
    font-size: 1rem;
    line-height: 1.7;
    color: rgba(13, 11, 26, 0.6);
    text-align: center;
  }

  @media (max-width: 700px) {
    .phones-row { gap: 0.75rem; }
    .phone-frame { width: 28vw; }
    .phone-frame.center { width: 34vw; }
  }
</style>
