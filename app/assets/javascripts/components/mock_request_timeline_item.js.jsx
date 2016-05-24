var MRTimelineItem = React.createClass({
    render: function() {
        return (
            <div className="request" onClick={ (e) => this.props.onClick(e,this.props.idx)}>
                <i className="fa fa-angle-right"></i> { this.props.request.created_at_time } | { this.props.request.method }
            </div>
        )
    }
});