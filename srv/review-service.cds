using {my.bookshop as my, ic} from '../db/index';

@path : 'review'
service ReviewService {
    entity Reviews as projection on my.Reviews;
    entity ProductReviews as projection on ic.ProductReviews;

    @readonly
    entity Books   as projection on my.Books excluding {
        createdBy,
        modifiedBy
    }

       @readonly
    entity Products   as projection on ic.Products excluding {
        createdBy,
        modifiedBy
    }

    @readonly
    entity Authors as projection on my.Authors;

    // access control restrictions
    annotate Reviews with @restrict : [
        {
            grant : '*',
            to : 'authenticated-user',
            where : 'createdBy=$user'
        },
        {
            grant : '*',
            to : 'admin',
        }
    ];

        // access control restrictions
    annotate ProductReviews with @restrict : [
        {
            grant : '*',
            to : 'authenticated-user',
            where : 'createdBy=$user'
        },
        {
            grant : '*',
            to : 'admin',
        }
    ];
}

annotate ReviewService.Reviews with @odata.draft.enabled;
annotate ReviewService.ProductReviews with @odata.draft.enabled;
