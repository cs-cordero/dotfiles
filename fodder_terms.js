import React from 'react';
import Term from 'glossary/Term';
import { Table, Well } from 'react-bootstrap';
import Katex from 'common/ui/components/Katex';
import Glossary from 'glossary/Glossary';

const SideDirectionMapping = React.createClass({
    render() {
        return (
            <Table bordered condensed hover>
                <thead>
                    <tr>
                        <th>Trade Side</th><th>Trade Direction</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><th>Buy</th><th>Long</th></tr>
                    <tr><th>Sell</th><th>Short</th></tr>
                    <tr><th>Cover Short</th><th>Long</th></tr>
                    <tr><th>Sell Short</th><th>Short</th></tr>
                </tbody>
            </Table>
        );
    }
});

Term('Symbol', {
    body() {
        return <div>
            A name of a <Glossary.security/>.  Often, but not always, a firm
            will use a security's <Glossary.ticker/> (on some exchange) as its
            symbol.
        </div>;
    },
    column_name: 'symbol',
    synonyms: ['secsym']
});

Term('Ticker', {
    body() {
        return <div>
            An exchange-specific name of a <Glossary.security/>.  For example,
            on many exchanges, Apple Inc. has ticker "AAPL".
        </div>
    },
    column_name: 'ticker'
});
