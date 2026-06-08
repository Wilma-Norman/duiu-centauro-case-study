<script>
  import { onMount } from 'svelte';
  import Hero          from './lib/Hero.svelte';
  import Stats         from './lib/Stats.svelte';
  import FeaturedVideo from './lib/FeaturedVideo.svelte';
  import Story         from './lib/Story.svelte';
  import Footer        from './lib/Footer.svelte';

  onMount(() => {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12 });

    document.querySelectorAll('.reveal, .slide-left, .slide-right')
      .forEach(el => observer.observe(el));
  });
</script>

<Hero />
<Stats />
<FeaturedVideo />
<Story />
<Footer />
