class MRTimeline extends React.Component {
    render() {
        return (
            <div className="timeline">
                {this.props.data.map(function(request,i) {
                    let isCurr = this.props.selectedId == request._id.$oid;
                    return <MRTimelineItem key={request._id.$oid} request={request} idx={i} isSelected={isCurr} onClick={this.props.onTimelineItemClick}/>
                }.bind(this))}
            </div>
        )
    }
}
