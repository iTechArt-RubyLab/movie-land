class RolesController < ApplicationController
  before_action :set_role, only: %i[show update destroy]

  # GET /roles
  def index
    @roles = Role.all

    render json: @roles
  end

  # GET /roles/1
  def show
    render json: @role
  end

  # POST /roles
  def create
    @role = Role.new(role_params)

    if @role.save
      render json: @role, status: :created, location: @role
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /roles/1
  def update
    if @role.update(role_params)
      render json: @role
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  # DELETE /roles/1
  def destroy
    @role.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def role_params
    params.require(:role).permit(:name, :can_give_role, :can_create_role, :can_read_entities, :can_edit_entities, :can_leave_rating, :can_read_rating, :can_read_movies, :can_edit_movies, :can_create_movie_without_approve, :can_approve_movies, :can_approve_redactor)
  end
end
