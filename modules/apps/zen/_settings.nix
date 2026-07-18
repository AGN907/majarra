{
  # Startup, onboarding, "default browser"
  "browser.startup.page" = 3; # Restore previous session
  "browser.startup.homepage" = "";
  "browser.startup.firstrunSkipsHomepage" = true;
  "browser.startup.homepage_override.mstone" = "ignore";

  "browser.aboutConfig.showWarning" = false;
  "browser.aboutwelcome.enabled" = false;
  "trailhead.firstrun.didSeeAboutWelcome" = true;

  "browser.shell.checkDefaultBrowser" = false;
  "browser.tabs.firefox-view" = false;

  # UI, tabs, URL bar
  "browser.ctrlTab.recentlyUsedOrder" = true;
  "browser.ctrlTab.previews" = true;
  "browser.ctrlTab.sortByRecentlyUsed" = true;

  "browser.toolbars.bookmarks.visibility" = "never"; # always|never|newtab
  "browser.bookmarks.defaultLocation" = "toolbar";
  "browser.bookmarks.restore_default_bookmarks" = false;

  "browser.urlbar.suggest.history" = false;
  "browser.urlbar.suggest.openpage" = false;
  "browser.urlbar.suggest.recentsearches" = false;
  "browser.urlbar.suggest.topsites" = false;

  # Search, recommendations, discovery
  "browser.search.update" = false;
  "browser.search.suggest.enabled" = false;
  "browser.search.suggest.enabled.private" = false;
  "browser.discovery.enabled" = false;

  # Extensions
  "extensions.update.enabled" = true;
  "extensions.extensions.activeThemeID" = "default-theme@mozilla.org";

  "extensions.screenshots.disabled" = true;
  "extensions.pocket.enabled" = false;

  "extensions.htmlaboutaddons.recommendations.enabled" = false;

  "extensions.ui.sitepermission.hidden" = true;
  "extensions.ui.locale.hidden" = true;
  "extensions.allowPrivateBrowsingByDefault" = true;

  "extensions.formautofill.available" = "off";
  "extensions.formautofill.addresses.enabled" = false;
  "extensions.formautofill.creditCards.available" = false;
  "extensions.formautofill.creditCards.enabled" = false;
  "extensions.formautofill.heuristics.enabled" = false;

  # Privacy, Security
  "privacy.query_stripping.enabled" = true;
  "privacy.query_stripping.enabled.pbmode" = true;
  "privacy.donottrackheader.enabled" = true;

  "privacy.purge_trackers.enabled" = true;
  "privacy.trackingprotection.enabled" = true;
  "privacy.trackingprotection.fingerprinting.enabled" = true;
  "privacy.trackingprotection.socialtracking.enabled" = true;
  "privacy.trackingprotection.cryptomining.enabled" = true;

  "privacy.resistFingerprinting" = false;
  "privacy.resistFingerprinting.block_mozAddonManager" = true;

  "dom.block_multiple_popups" = true;
  "privacy.popups.disable_from_plugins" = 3;

  # Login / autofill
  "signon.rememberSignons" = false;

  # Performance, Media
  "gfx.webrender.all" = true; # Force enable GPU acceleration
  "widget.dmabuf.force-enabled" = true; # Required in recent Firefoxes
  "media.ffmpeg.vaapi.enabled" = true;
  "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;
  "privacy.webrtc.legacyGlobalIndicator" = false;
  "reader.parse-on-load.force-enabled" = true;

  "network.http.http3.enabled" = true;

  # Zen specific
  "zen.urlbar.behavior" = "float";
  "zen.urlbar.replace-newtab" = true;

  "zen.view.compact.enable-at-startup" = true;
  "zen.view.compact.hide-tabbar" = true;
  "zen.view.compact.hide-toolbar" = true;
  "zen.view.experimental-no-window-controls" = true;
  "zen.view.sidebar-expanded" = true;
  "zen.view.use-single-toolbar" = true;

  "zen.watermark.enable" = false;
  "zen.workspaces.continue-where-left-off" = true;
  "zen.welcome-screen.seen" = true;

  "zen.tabs.vertical.right-side" = true;
  "theme.floating_history.position" = "left";
  "layout.scrollbar.side" = 3;
}
