@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Association Example 2'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZAP_ASSO_EX02 as select from /dmo/customer
association[* ] to ZAP_ASSO_EX01 as _cust on $projection.customer = _cust.customer
{
    key customer_id as customer,
    concat_with_space( first_name, last_name, 2 ) as Name,
    _cust
}
