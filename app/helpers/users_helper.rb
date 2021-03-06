module UsersHelper
  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=200"
  end

  def favorited_item_name(item)
    if item.favorited_type == "Snippet"
      link_to item.favorited.title, snippet_path(item.favorited_id)
    else
      link_to item.favorited.name, theme_path(item.favorited_id)
    end
  end

  def total_number_of_favorites(user)
    total_snippet_faves = user.favorite_snippets.count
    total_theme_faves = user.favorite_themes.count

    pluralize(total_theme_faves + total_snippet_faves, "favorite")
  end

  def user_is_current_user(user_id)
    current_user && current_user.id == user_id
  end
end
