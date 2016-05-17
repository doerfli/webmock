var HistoryRequestsItem = React.createClass({
  render: function() {
    return (
        <div className="request">
            <div className="row">
                <div className="col-sm-6">
                    { this.props.request.method }
                </div>
                <div className="col-sm-6">
                    { this.props.request.created_at_time }
                </div>
            </div>
            <div className="row">
                <div className="col-sm-6">
                    { this.props.request.remote_address }
                </div>
                <div className="col-sm-6">
                    { this.props.request.created_at_date }
                </div>
            </div>
        </div>
    )
  }
});