const table={
    currentPage:1,
    pageCount:0,
    from:1,
    to:5,
    data:[],
    load:()=>{
        fetch('/fswd/get-users.php', {
            method: 'POST', 
            body: JSON.stringify({
                from:table.from,
                to:table.to
            }),
            headers:{'Content-Type': 'application/json'}
            }).then(res => res.json())
            .then(res=> {
                // console.log(res);
                if(res.noSession){
                    document.location.href  = '/fswd/login.html';
                }
                table.pageCount = res.total;
                table.data = res.rows;    
                table.renderData();
            })
            .catch(error => console.error('Error:', error));
    },
    renderData(){
        table.renderRows();
        table.renderPaginationButtons();
    },
    renderRows:()=>{
        getBy.id('table-rows').innerHTML= table.data.map(item=>
            "<tr><td>".concat(
                '<img class="status" src="/fswd/assets/',item.status_id,'.png" />',
                '</td>',
                '<td><label>',item.id,'</label><br><label class="text-gray">',item.name,'</label></td>',
                '<td><label>','...','</label><br><label class="text-gray">','Default Group','</label></td>','</tr>')
        ).join('');
    },
    renderPaginationButtons:()=>{
        getBy.id('pagination').innerHTML= new Array(Math.round(table.pageCount/5)).fill().map((item,index)=> " <a".concat(' class="',
        table.currentPage===index+1? 'selected-page':'page',
        '" onClick="table.setPage(',index+1,')">',
        index+1,
        '</a> ')).join('').concat(' <a class="page" onClick="table.next()">Next >></a> ');
    },
    next:()=>{
        if(table.currentPage!==Math.round(table.pageCount/5)){
            table.from=table.from+5;
            table.to=table.to+5;
            table.currentPage++;
            table.load();
        }
    },
    setPage:page=>{
        table.from=(page*5)-5;
        table.to=page*5;
        table.currentPage=page;
        table.load();
    }
};

table.load();