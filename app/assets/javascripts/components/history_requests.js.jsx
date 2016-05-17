var HistoryRequests = React.createClass({
    getInitialState: function() {
        return { requests: this.props.data };
    },
    getDefaultProps: function() {
        return { requests: [] };
    },
    render: function() {
      return (
        <div className="history">
          <h3>History</h3>
            {this.state.requests.map(function(request) {
                return <HistoryRequestsItem key={request._id.$oid} request={request} />
            }.bind(this))}
        </div>
      )
    }
});

