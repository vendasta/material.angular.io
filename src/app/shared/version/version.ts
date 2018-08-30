import {VERSION} from '@angular/material';

/** This material version will be used in footer and stackblitz. */
export const materialVersion = VERSION.full;

/** Version information with title and redirect url */
export interface VersionInfo {
  url: string;
  title: string;
}

/** Doc site versions. We update the urls and titles manually */
export const docVersions: VersionInfo[] = [
  {
    url: `https://vendasta.com/style/`,
    title: materialVersion
  }
];
