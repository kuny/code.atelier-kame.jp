import matter from "gray-matter";
export const prerender = true;
export type Post = {
  slug: string;
  title: string;
  date: string;
  tags: string[];
};

export const load = async () => {
  // content/*.md を全部読む（raw文字列）
  const modules = import.meta.glob("../../content/*.md", {
    as: "raw"
  });

  const entries = await Promise.all(
    Object.entries(modules).map(async ([path, loader]) => {
      const raw = await loader();
      const { data } = matter(raw);

      const slug = path.split("/").pop()!.replace(/\.md$/, "");
      return {
        slug,
        title: String(data.title ?? slug),
        date: String(data.date ?? ""),
        tags: Array.isArray(data.tags) ? data.tags.map(String) : []
      } satisfies Post;
    })
  );

  // 新しい順
  entries.sort((a, b) => (a.date < b.date ? 1 : -1));

  return { posts: entries };
};
