import { scrubPiFingerprints } from "./scrub.js";
const plugin = {
    name: "pi-scrub",
    version: "0.2.0",
    description: "Strip pi-identifying fingerprints from the system prompt before it reaches Claude (all adapters; content-scoped)",
    onRequest(ctx) {
        if (!ctx.systemContext)
            return ctx;
        const scrubbed = scrubPiFingerprints(ctx.systemContext);
        if (scrubbed === ctx.systemContext)
            return ctx;
        return { ...ctx, systemContext: scrubbed };
    },
};
export default plugin;
export { scrubPiFingerprints };
