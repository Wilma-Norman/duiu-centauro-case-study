<script>
	import { decode } from 'blurhash';
	import { onMount } from 'svelte';
	import { cn } from './utils.js';

	let {
		hash,
		width = 32,
		height = 32,
		class: className = undefined
	} = $props();

	let canvas = $state(undefined);

	function renderBlurhash() {
		if (!hash || !canvas) return;

		try {
			const pixels = decode(hash, width, height);
			const ctx = canvas.getContext('2d');
			if (!ctx) return;
			const imageData = ctx.createImageData(width, height);
			imageData.data.set(pixels);
			ctx.putImageData(imageData, 0, 0);
		} catch (error) {
			console.warn('Failed to decode blurhash:', error);
		}
	}

	onMount(() => {
		renderBlurhash();
	});

	$effect(() => {
		if (hash && canvas) {
			renderBlurhash();
		}
	});
</script>

{#if hash}
	<canvas
		bind:this={canvas}
		{width}
		{height}
		class={cn('absolute inset-0 h-full w-full', className)}
		style="filter: blur(40px); transform: scale(1.2);"
	></canvas>
{/if}
