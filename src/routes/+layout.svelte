<script lang="ts">
    import '$lib/assets/layout.css';
	let { children } = $props();
</script>

<svelte:head>
</svelte:head>


  <div class="container">
    <div class="content">
{@render children()}
    </div>
  </div>
