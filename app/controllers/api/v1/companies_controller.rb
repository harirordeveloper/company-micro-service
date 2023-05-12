class Api::V1::CompaniesController < Api::V1::BaseController

  before_action :find_company
  before_action :authorize_admin_user!

  def update
    if @company.update(company_params)
      KafkaService.send_message("company", { action: "update", resource: 'Company', service_id: 'company_service', data: company.as_json })
      render_resource @company, ::Api::V1::CompanySerializer, :ok
    else
      render_error @company.errors.full_messages, :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :address_line_1, :address_line_2, :phone)
  end

  def find_company
    @company = Company.find_by_id(params[:id])
    render_error "No company found with the matching ID :: #{params[:id]}", :not_found
  end
end
