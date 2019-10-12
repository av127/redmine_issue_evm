# evmasignee controller
class EvmparentissuesController < BaseevmController
  #
  # View of parent issues of EVM
  #
  def index
    # View options
    @cfg_param[:basis_date] = params[:basis_date]
    @cfg_param[:selected_parent_issue_id] = params[:selected_parent_issue_id]
    @cfg_param[:no_use_baseline] = "True"
    @cfg_param[:forecast] = "False"
    @cfg_param[:display_performance] = "False"
    @cfg_param[:display_incomplete] = "False"
    #selectable parent issue
    @selectable_parent_issue = selectable_parent_issues_list
    # EVM optional (parent issue)
    @parent_issue_evm = {}
    unless @cfg_param[:selected_parent_issue_id].nil?
      @cfg_param[:selected_parent_issue_id].each do |issue_id|
        # issues of parent issue
        parent_issue = parent_issues issue_id
        # spent time of parent issue
        parent_issue_actual_cost = parent_issue_costs issue_id
        # create array of EVM
        @parent_issue_evm[issue_id] = CalculateEvm.new nil,
                                                       parent_issue,
                                                       parent_issue_actual_cost,
                                                       @cfg_param
      end
    end
  end
end
