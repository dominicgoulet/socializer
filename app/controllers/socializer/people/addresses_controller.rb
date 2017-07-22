# frozen_string_literal: true

#
# Namespace for the Socializer engine
#
module Socializer
  module People
    #
    # Address controller
    #
    class AddressesController < ApplicationController
      before_action :authenticate_user

      # GET /people/1/addresses/new
      def new
        respond_to do |format|
          format.html { render :new, locals: { address: addresses.new } }
        end
      end

      # GET /people/1/addresses/1/edit
      def edit
        respond_to do |format|
          format.html { render :edit, locals: { address: find_address } }
        end
      end

      # POST /people/1/addresses
      def create
        address = addresses.build(person_address_params)

        if address.save
          flash[:notice] = t("socializer.model.create", model: "Address")
          redirect_to current_user
        else
          render :new
        end
      end

      # PATCH/PUT /people/1/addresses/1
      def update
        address = find_address
        address.update!(person_address_params)

        flash[:notice] = t("socializer.model.update", model: "Address")
        redirect_to current_user
      end

      # DELETE /people/1/addresses/1
      def destroy
        address = find_address
        address.destroy

        flash[:notice] = t("socializer.model.destroy", model: "Address")
        redirect_to current_user
      end

      private

      def addresses
        @addresses ||= current_user.addresses
      end

      def find_address
        @find_address ||= addresses.find_by(id: params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def person_address_params
        params.require(:person_address)
              .permit(:line1, :line2, :city, :postal_code_or_zip,
                      :province_or_state, :country)
      end
    end
  end
end
