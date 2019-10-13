# Trackers EVM controller.
# This controller provide tracker evm view.
#
# 1. selectable list for tracker view
# 2. calculate EVM each selected trackers
# 
class EvmtrackersController < BaseevmController
  # index for tracker EVM view.
  # 
  # 1. set options of view request
  # 2. get selectable list
  # 3. calculate EVM
  #
  def index
    # View options
    @cfg_param[:basis_date] = params[:basis_date]
    @cfg_param[:selected_tracker_id] = params[:selected_tracker_id]
    @cfg_param[:no_use_baseline] = "True"
    @cfg_param[:forecast] = "False"
    @cfg_param[:display_performance] = "False"
    @cfg_param[:display_incomplete] = "False"
    # selectable tracker    
    @selectable_tracker = @project.trackers
    # calculate EVM (tracker)
    condition = {tracker_id: params[:selected_tracker_id]}
    # issues of trackers
    tracker_issues = evm_issues @project, condition
    # spent time fo trackers
    tracker_actual_cost = evm_costs @project, condition
    @tracker_evm = CalculateEvm.new nil,
                                    tracker_issues,
                                    tracker_actual_cost,
                                    @cfg_param
  end
end
