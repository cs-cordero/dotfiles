makeReportTemplate({
    reportParams: [
        {
            longName: 'Security',
            shortName: 'sec',
            pluralName: 'Securities',
            dualName: 'Account',
            dualPlural: 'Accounts',
            topPnlsQuery: 'sec_pnls_allacct',
            fullPnlsQuery: 'get_full_sec_pnl',
            heldBy: 'held by or traded by',
            intent: "which made (or lost) the most money for this Firm's Clients",
        },
        {
            longName: 'Account',
            shortName: 'account',
            pluralName: 'Accounts',
            dualName: 'Security',
            dualPlural: 'Securities',
            topPnlsQuery: 'acct_pnls_allsec',
            fullPnlsQuery: 'get_full_account_pnl',
            heldBy: 'that held or traded',
            intent: 'which made or lost the most money',
        },
    ],

    displayName({ longName }) {
        return `Holdings/P&L for ${longName} (General)`;
    },

    meta({ longName }) {
        return [ 'holdings/P&L', longName, 'aggregated' ];
    },

    summary({longName, intent, pluralName, dualPlural, heldBy, dualName}) {
        intent = `${pluralName} ${intent}`;

        return (
            <div>
                <p>
                    This report presents information about the total{' '}
                    {sb.holdingsAndPnlPreamble} of the {pluralName} involved in
                    the exam.  The intent of this report is to highlight
                    the {intent}.
                </p>
                <p>
                    NEAT calculates the Holdings and subsequence PNLs for all{' '}
                    {pluralName} {heldBy} each {dualName}.  Then for each {longName},
                    NEAT aggregates these Holdings and PNLs across all {dualPlural}.
                </p>
                <p>
                    <i className='fa fa-thumbs-up'/> This is a particularly
                    good report if you are just beginning an exam and don&apos;t
                    yet know which {pluralName} are most important.
                    Once some outlying {pluralName} have been identified, then
                    you can use a more specific, lower-level report to
                    examine them in closer detail.
                </p>
            </div>
        );
    },


// ====================================================
// ====================================================
// ====================================================
// ====================================================
// ====================================================


makeReport({
    displayName: 'Account Turnover',
    meta: [ 'regulation', 'commissions and fees' ],

    summary: (
        <div>
            <p>
                This report presents various views related to{' '}
                <Glossary.Turnover/>, including <Glossary.TurnoverRatio/>, all
                with respect to individual Accounts.
            </p>

            <p>
                One reason we are interested in Turnover is because a
                high Turnover in an Account might, in some instances, be a clue
                that the Account is being charged unfair{' '}
                <Glossary.CommissionsAndFees/>.
            </p>

            <p>
                Some Investment Companies report information about portfolio
                turnover on the {N1ALink}.  Discrepancies between this report
                and those reported numbers, either regarding an individual
                Account or regarding Accounts as a whole, could warrant closer
                inspection.
            </p>

            <p>
                <i className='fa fa-info-circle'/> Note: If no initial
                position file was uploaded for this case, then the Turnover
                will be annualized as if initial positions were
                zero at the start of the exam period. This may make the results
                inaccurate.  If initial positions were uploaded into NEAT then
                Turnover will be annualized as if those positions were opened
                on the initial position date, which may be inaccurate if the
                positions were held for a longer time before the exam period.
            </p>

            <p>
                <i className='fa fa-info-circle'/> Note: NEAT currently has
                no notion of a cash blotter.  NEAT calculates Account Turnover
                as if all Accounts always maintain zero cash on hand.  If an
                Account maintains a large cash balance with the Firm, relative
                to the value of that Account's Security holdings, then this
                report might suggest the Account has a larger Turnover than it
                actually does.
            </p>
        </div>
    ),

    render_: function () {

        const comm = dropdown({
            data: {
                'Commissions Only'  : 'sum_comm',
                'Fees Only'         : 'sum_fee',
                'Commissions + Fees': 'sum_comm_fee',
            },
            defaultValue: 'sum_comm',
        });

        const thresh_dd = dropdown({
            data: {
                '0%'  : 0,
                '50%' : 0.5,
                '75%' : 0.75,
                '100%': 1,
                '150%': 1.5,
                '200%': 2,
                '300%': 3,
                '500%': 5,
            },
            defaultValue: 0,
            ref: 'threshold',
        });

        const holdings_and_fees = q.base.get_turnover_summary({
            ratio_threshold: thresh_dd
        });

        const holdings_and_fees_table = q.jsutil.set_column_sequence({
            data: holdings_and_fees,
            first: [ 'account', 'turnover_annualized' ],
        });

        return (
            <div>
                <Dropdown query={comm}>
                    Please select which trade costs you would like to focus on.
                </Dropdown>

                <Dropdown query={thresh_dd}>
                    Choose the turnover threshold.  This is the threshold for
                    total traded cash-value over largest cash-value held.  If
                    you choose a threshold of 0 (the default) then no filter
                    will be applied and you will be shown all accounts.
                </Dropdown>

                <Row layout={[ 6, 6 ]}>
                    <Scatter
                        query={holdings_and_fees}
                        X='turnover_annualized'
                        Y='cashvalue_magnitude'
                        hoverCols={[ 'account' ]}
