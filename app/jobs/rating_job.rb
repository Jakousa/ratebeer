class RatingJob
  include SuckerPunch::Job

  def perform
    UserController::expire_fragment('ratingpage')
    visit ratings_path
  end
end
