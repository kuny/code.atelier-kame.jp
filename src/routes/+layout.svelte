<script lang="ts">
	import favicon from '$lib/assets/favicon.svg';
    import '$lib/assets/layout.css';
	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" href={favicon} />
</svelte:head>


  <div class="container">
    <div class="content">
{@render children()}
    </div>
  </div>
