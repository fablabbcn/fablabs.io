# Be sure to restart your server when you modify this file.

# Additional asset load paths (Propshaft serves everything in the load path).
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "stylesheets", "fontawesome")

# Stylesheets and JavaScripts here are build-tool sources (Dart Sass / esbuild /
# Tailwind); the compiled output lives in app/assets/builds. Excluding the
# source dirs prevents their raw contents from being served/precompiled.
# Rails.application.config.assets.excluded_paths << Rails.root.join("app/assets/stylesheets")
# Rails.application.config.assets.excluded_paths << Rails.root.join("app/assets/javascripts")
# Rails.application.config.assets.excluded_paths << Rails.root.join("node_modules")
