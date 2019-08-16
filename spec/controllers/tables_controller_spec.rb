require "rails_helper"
include SessionsHelper

RSpec.describe TablesController, type: :controller do
  let(:user) {FactoryBot.create :user}
  let(:valid_params) {FactoryBot.attributes_for :table}
  let(:invalid_params) {FactoryBot.attributes_for :table, number: ""}
  subject {FactoryBot.create :table}

  context "user is manager" do
    before do
      manager = FactoryBot.create :user, role: Settings.role.manager
      log_in manager
    end

    describe "GET #index" do
      it do
        get :index
        expect(response).to render_template "index"
      end
    end

    describe "GET #new" do
      it "assigns @new" do
        expect(assigns(:table)).to eq assigns(subject)
      end

      it do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it do
          expect {
            post :create, params: {table: valid_params}
          }.to change(Table, :count).by 1
        end

        it do
          post :create, params: {table: valid_params}
          expect(response).to redirect_to table_path(Table.last)
        end
      end

      context "with invalid params" do
        it do
          post :create, params: {table: invalid_params}
          expect(response).to render_template :new
        end
      end
    end

    describe "GET #edit" do
      it "assigns @table" do
        expect(assigns(:table)).to eq assigns(subject)
      end

      it "logined get edit" do
        get :edit, params: {id: subject.id}
        expect(response).to render_template "edit"
      end

      context "resource not found" do
        it "get edit fail"  do
          get :edit, params: {id: 0}
          expect(response).to redirect_to root_path
        end
      end     
    end

    describe "PATCH #update" do
      context "with valid params" do
        it "assigns @table" do
          expect(assigns(:table)).to eq assigns(table)
        end

        let(:new_attributes) do
          FactoryBot.attributes_for :table, name: "baynv"
        end

        it do
          patch :update, params: {id: subject.id, table: new_attributes}
          subject.reload
          expect(subject.number).to eq new_attributes[:number]
        end

        it do
          patch :update, params: {id: subject, table: new_attributes}
          expect(response).to redirect_to table_path(subject)
        end
      end

      context "with invalid params" do
        it do
          patch :update, params: {id: subject.id, table: invalid_params}
          expect(response).to render_template :edit
        end
      end
  
      context "resource not found" do
        it do
          patch :update, params: {id: 0}
          expect(response.status).to redirect_to root_path
        end
      end
    end

    describe "DELETE #destroy" do
      context "resource exist" do
        it "assigns @table" do
          expect(assigns(:table)).to eq assigns(table)
        end

        it do
          delete :destroy, params: {id: subject.id}
          expect(flash[:success]).to eq I18n.t("tables.destroy.delete_s")
        end

        it do
          delete :destroy, params: {id: subject.id}
          expect(response).to redirect_to tables_url
        end
      end

      context "resource not found" do
        it do
          delete :destroy, params: {id: 0}
          expect(response.status).to redirect_to root_path
        end
      end
    end
  end
end
