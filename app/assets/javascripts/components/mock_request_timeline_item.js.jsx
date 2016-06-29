var MRTimelineItem = React.createClass({
    render: function() {
        var clsn = "request ";
        clsn += this.props.request.method;
        if ( this.props.isSelected == true ) {
            clsn += " selected";
        }
        return (
            <div className={clsn} onClick={ (e) => this.props.onClick(e,this.props.idx)}>
                <i className="fa fa-angle-right"></i> { this.props.request.created_at_time } | { this.props.request.method }
            </div>
        )
    }
});