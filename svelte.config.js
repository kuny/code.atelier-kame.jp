import { mdsvex } from 'mdsvex';
import adapter from '@sveltejs/adapter-static';
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';

/** @type {import('@sveltejs/kit').Config} */
const config = {
    preprocess: [
        vitePreprocess(),
        mdsvex({
            extensions: ['.svx', '.md']
        })
    ],
	kit: {
		// adapter-auto から adapter-static に変更
		adapter: adapter({
			pages: 'build',
			assets: 'build',
			fallback: '404.html',
			precompress: false,
			strict: true
		})
	},

    extensions: ['.svelte', '.svx', '.md']
};

export default config;

