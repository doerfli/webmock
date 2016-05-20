var MRTimeline = React.createClass({
    render: function() {
      return (
        <div className="timeline">
            {this.props.data.map(function(request,i) {
                return <MRTimelineItem key={request._id.$oid} request={request} idx={i} onClick={this.props.onTimelineItemClick}/>
            }.bind(this))}
        </div>
      )
    }
});

