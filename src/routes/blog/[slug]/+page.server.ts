import { error } from "@sveltejs/kit";
import matter from "gray-matter";

export const load = async ({ params }) => {
  const slug = params.slug;

  const modules = import.meta.glob("../../../content/*.md", { as: "raw" });

  const match = Object.entries(modules).find(([path]) =>
    path.endsWith(`/${slug}.md`)
  );

  if (!match) throw error(404, "Not found");

  const raw = await match[1]();
  const { data, content } = matter(raw);

  return {
    slug,
    title: String(data.title ?? slug),
    date: String(data.date ?? ""),
    tags: Array.isArray(data.tags) ? data.tags.map(String) : [],
    content // ここはまずプレーン表示
  };
};
