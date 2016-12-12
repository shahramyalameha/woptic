!!! woptic/src/indexx.f90
!!!
!!!    Sort with heapsort (from Numerical Recipes, p.233)
!!!

      subroutine indexx(arrin,indx,n)
      implicit none

      integer :: n,j,l,i,indxt,ir
      integer :: arrin(n),indx(n),q

      do 11 j=1,n
  11  indx(j)=j
      L=n/2+1
      ir=n
  10  continue
      if(l.gt.1) then
      l=l-1
      indxt=indx(l)
      q=arrin(indxt)            
      else
      indxt=indx(ir)
      q=arrin(indxt)
      indx(ir)=indx(1)
      ir=ir-1
      if(ir.le.1) then
       indx(1)=indxt
       return
      endif
      endif
      i=l
      j=l+l
  20  if(j.le.ir) then
        if(j.lt.ir) then
          if(arrin(indx(j)).lt.arrin(indx(j+1))) j=j+1
        end if
        if(q.lt.arrin(indx(j))) then
          indx(i)=indx(j)
          i=j
          j=j+j
         else
          j=ir+1
        end if
        goto 20
      end if
      indx(i)=indxt
      goto 10
      end
