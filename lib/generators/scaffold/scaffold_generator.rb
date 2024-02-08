class ScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)
  
  hook_for :scaffold, in: :rails, type: :boolean, default: true
  
  def add_turbo_refreshes_to_model
    # Skip if revoking because `hook_for :scaffold` has already removed the model
    return if behavior == :revoke
    
    inject_into_class File.join("app/models", class_path, "#{file_name}.rb"), class_name do
      "  broadcasts_refreshes\n"
    end
  end
end
