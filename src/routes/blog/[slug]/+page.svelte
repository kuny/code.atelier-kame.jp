<script lang="ts">
  export let data: {
    title: string;
    date: string;
    tags: string[];
    content: string;
  };
</script>

<h1>
(atelier-kame 'code
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'blog)
</h1>
<h2>{data.title}</h2>
{#if data.date}<p><small>{data.date}</small></p>{/if}

<pre style="white-space: pre-wrap; line-height: 1.6;">{data.content}</pre>
