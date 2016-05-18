var MRTimeline = React.createClass({
    getInitialState: function() {
        return { requests: this.props.data };
    },
    getDefaultProps: function() {
        return { requests: [] };
    },
    render: function() {
      return (
        <div className="timeline">
            {this.state.requests.map(function(request) {
                return <MRTimelineItem key={request._id.$oid} request={request} />
            }.bind(this))}
        </div>
      )
    }
});

