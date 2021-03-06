class RepositoriesController < ApplicationController
  before_action :set_repository, only: %i[ show edit update destroy remove_user add_user ]

  # GET /repositories or /repositories.json
  def index
    if params[:keyword]
      @repositories = Repository.includes(:user).search(params[:keyword])

    else
      @repositories = Repository.includes(:user).all
    end
    @keyword = params[:keyword]
   
  end

  # GET /repositories/1 or /repositories/1.json
  def show
    @remaining_users = User.where.not(id: @repository.users.ids)
  end

  # GET /repositories/new
  def new
    @repository = Repository.new
  end

  # GET /repositories/1/edit
  def edit
  end

  # POST /repositories or /repositories.json
  def create
    @repository = Repository.new(repository_params)

    respond_to do |format|
      if @repository.save
        format.html { redirect_to repository_url(@repository), notice: "Repository was successfully created." }
        format.json { render :show, status: :created, location: @repository }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repositories/1 or /repositories/1.json
  def update
    respond_to do |format|
      if @repository.update(repository_params)
        format.html { redirect_to repository_url(@repository), notice: "Repository was successfully updated." }
        format.json { render :show, status: :ok, location: @repository }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repositories/1 or /repositories/1.json
  def destroy
    @repository.destroy

    respond_to do |format|
      format.html { redirect_to repositories_url, notice: "Repository was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def remove_user
    @repository.users.destroy(params[:user_id])

    respond_to do |format|
      format.html { redirect_to @repository, notice: "User was successfully removed." }
      format.json { head :no_content }
    end
  end

  def add_user
    @repository.users.push(User.find params[:user_id])
    if @repository.save
      respond_to do |format|
        format.html { redirect_to @repository, notice: "User was successfully added." }
        format.json { head :no_content }
      end
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repository
      @repository = Repository.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def repository_params
      params.require(:repository).permit(:name, :description, :user_id)
    end
end
