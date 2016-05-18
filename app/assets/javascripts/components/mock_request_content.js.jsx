var MRContent = React.createClass({
    render: function() {
        return (
            <div className="content">
                <dl className="dl-horizontal">
                    {Object.keys(this.props.data.headers).map(function (key) {
                        var value =  this.props.data.headers[key];
                        return (
                            <span key={key}>
                                <dt>{key}</dt>
                                <dd>{value}</dd>
                            </span>
                        )
                    }.bind(this))}
                </dl>
            </div>
        )
    }
});