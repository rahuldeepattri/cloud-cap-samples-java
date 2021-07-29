namespace ic;

using {
    Currency,
    sap,
    managed,
    cuid,
    User
} from '@sap/cds/common';
using {my.bookshop as my} from './common';

@fiori.draft.enabled
entity Products : cuid, managed {
    title        : localized String(111);
    descr        : localized String(1111);
    stock        : Integer;
    price        : Decimal(9, 2);
    currency     : Currency;
    rating       : Decimal(2, 1);
    reviews      : Association to many ProductReviews
                       on reviews.product = $self;
    isReviewable : my.TechnicalBooleanFlag not null default true;
}

entity ProductReviews : cuid, managed {
    @cds.odata.ValueList
    product   : Association to Products;
    rating : Rating;
    title  : String(111);
    text   : String(1111);
}

// input validation
annotate Reviews with {
    subject @mandatory;
    title @mandatory;
    rating @assert.range;
}

type Rating : Integer enum {
    Best  = 5;
    Good  = 4;
    Avg   = 3;
    Poor  = 2;
    Worst = 1;
}
