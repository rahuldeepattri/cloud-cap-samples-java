using {
    my.bookshop as my,
    ic
} from '../db/index';

@path : 'browse'
service CatalogService {
    @readonly
    entity Books          as projection on my.Books excluding {
        createdBy,
        modifiedBy
    } actions {
        action addReview(rating : Integer, title : String, text : String) returns Reviews;
    };

    @readonly
    entity Authors        as projection on my.Authors;

    @readonly
    entity Reviews        as projection on my.Reviews;

    @readonly
    entity Products       as projection on ic.Products excluding {
        createdBy,
        modifiedBy
    } actions {
        action addProductReview(rating : Integer, title : String, text : String) returns ProductReviews;
    };

    @readonly
    entity ProductReviews as projection on ic.ProductReviews;

    action submitOrder(book : Books:ID, amount : Integer) returns {
        stock : Integer
    };

    // access control restrictions
    annotate Reviews with @restrict : [
        {
            grant : 'READ',
            to : 'any'
        },
        {
            grant : 'CREATE',
            to : 'authenticated-user'
        }
    ];

    // access control restrictions
    annotate ProductReviews with @restrict : [
        {
            grant : 'READ',
            to : 'any'
        },
        {
            grant : 'CREATE',
            to : 'authenticated-user'
        }
    ];
}
