<script lang="ts">
  export let data: { posts: { slug: string; title: string; date: string; tags: string[] }[] };
</script>

<h1>
(atelier-kame 'code
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'blog)
</h1>

<ul>
  {#each data.posts as p}
    <li>
      <a href={"/blog/" + p.slug}>{p.title}</a>
      {#if p.date} <small> — {p.date}</small>{/if}
    </li>
  {/each}
</ul>
