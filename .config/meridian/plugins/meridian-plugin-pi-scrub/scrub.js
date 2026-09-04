const PI_IDENTITY_LINE = /You are an expert coding assistant operating inside pi, a coding agent harness\.[^\n]*\n+/;
const PI_DOCS_BLOCK = /Pi documentation \(read only when[\s\S]*?(?=\n\n|\nCurrent date:|$)/;
const DUPLICATE_ENV_PREAMBLE_BLOCK = /\nHere is some useful information about the environment you are running in:\n<env>[\s\S]*?<\/env>\n/;
const GENERIC_IDENTITY = "You are an expert coding assistant. You help users by reading files, executing commands, editing code, and writing new files.\n";
export function scrubPiFingerprints(systemPrompt) {
    if (!systemPrompt)
        return systemPrompt;
    return systemPrompt
        .replace(PI_IDENTITY_LINE, GENERIC_IDENTITY)
        .replace(PI_DOCS_BLOCK, "")
        .replace(DUPLICATE_ENV_PREAMBLE_BLOCK, "\n")
        .replace(/\n{3,}/g, "\n\n")
        .replace(/\s+$/, "");
}
